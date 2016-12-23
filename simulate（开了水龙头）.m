% Simulate the change of temperature in the bathtub.
%   By using the finite difference method.

% Set up the size and step length.

maxX = 20;
lengthX = 0.09; % unit: meter
maxY = 20;
lengthY = 0.03; % unit: meter
maxH = 20;
lengthH = 0.02; % unit: meter
maxT = 5000;
lengthT = 2; % unit: second

% Update the value.

wSide = 0.1; % unit: meter
wDown = 0.3; % unit: meter
kHeat = 0.59; % unit: W/(m¡¤K)
kHeatWall = 0.19;
alpha = kHeat / (4.18*1000) / (1000); % unit: m^2/s
alphaWall = kHeatWall / 900 / 2600;

% Set up the position and size of human body. Assume inside the body, the temperature is
% always 37¡æ¡£
bodyLeft = uint16(maxX * 1 / 10);
bodyRight = uint16(maxX * 9 / 10);
bodyFront = uint16(maxY * 1 / 10);
bodyBehind = uint16(maxY * 9 / 10);
bodyUp = uint16(maxH * 5 / 10);
bodyDown = uint16(maxH * 9 / 10);

% Set up the parameters about adding water and overflowing.
water_per_second = 0.3 / 1000; % unit: cubic meter
maxR = sqrt(3*water_per_second / (lengthH*maxH) / 3.14159265359); 
u = 5;   % X-Position of the water source.
v = 5;   % Y-Position of the water source.
r = 15;   % X-Position of the water drain.
s = 15;   % Y-Position of the water drain.

% Set up the initial temperature.
t = zeros(maxX, maxY, maxH, maxT); % t = f(x, y, h, time); h = 0 means upside
backup = zeros(maxX, maxY, maxH);
t(:,:,:,1) = 40; % The initial temperature of water in the bathtub is 40¡æ. time = 1 means the start.
t(bodyLeft:bodyRight, bodyFront:bodyBehind, bodyUp:bodyDown, 1) = 37;
tAir = 15; % The temperature of air is 15¡æ.

for T = 1 : (maxT - 1)
    t(bodyLeft:bodyRight, bodyFront:bodyBehind, bodyUp:bodyDown, T+1) = 37;
    for h = 1 : (maxH - 1)
        R_at_this_h = maxR * (maxH - h) / (maxH - 1);
        for x = 2 : (maxX - 1)
            for y = 2 : (maxY - 1)
                deltaT = 0;
                tNow = t(x,y,h,T);
                k = (2.614 + (3.305 - 1.810) / 200 * (tNow - 300)) * 0.01;
                b = 1 / (tNow + 273);
                a = (2.207 + (3.693 - 1.015) / 200 * (tNow - 300)) * 0.00001;
                V = (1.583 + (2.639 - 0.758) / 200 * (tNow - 300)) * 0.00001;
                hCoefficient = 0.15 * k * (9.80665 * b * (tNow-tAir)/a/V)^(1/3) * 100;
                
                % Consider the flow caused by the source and drain
                % separately.
                distance = sqrt(((x-u)*lengthX)^2+((y-v)*lengthY)^2);
                velocity = 0;
                if distance <= R_at_this_h
                    t(x, y, h, T+1) = 40;
                    continue;
                else
                    velocity = 3 * water_per_second * R_at_this_h^2 / (maxR^2) / (maxH * lengthH) / (2 * 3.1416 * distance);
                end
                
                cosA = abs((x-u)*lengthX / distance);
                sinA = abs((y-v)*lengthY / distance);
                hori = lengthT * velocity * cosA / lengthX;
                vert = lengthT * velocity * sinA / lengthY;
                if x > u
                    deltaT = deltaT + hori * (t(x-1,y,h,T) - tNow);
                else if x < u
                    deltaT = deltaT + hori * (t(x+1,y,h,T) - tNow);
                    end
                end
                if y > v
                    deltaT = deltaT + vert * (t(x,y-1,h,T) - tNow);
                else if y < v
                    deltaT = deltaT + vert * (t(x,y+1,h,T) - tNow);
                    end
                end
                
                distance = sqrt(((x-r)*lengthX)^2+((y-s)*lengthY)^2);
                velocity = 0;
                if distance ~= 0
                    velocity = 3 * water_per_second * R_at_this_h^2 / (maxR^2) / (maxH * lengthH) / (2 * 3.1416 * distance);

                    cosA = abs((x-r)*lengthX / distance);
                    sinA = abs((y-s)*lengthY / distance);
                    hori = lengthT * velocity * cosA / lengthX;
                    vert = lengthT * velocity * sinA / lengthY;
                    if x > r
                        deltaT = deltaT + hori * (t(x+1,y,h,T) - tNow);
                    else if x < r
                        deltaT = deltaT + hori * (t(x-1,y,h,T) - tNow);
                        end
                    end
                    if y > s
                        deltaT = deltaT + vert * (t(x,y+1,h,T) - tNow);
                    else if y < s
                        deltaT = deltaT + vert * (t(x,y-1,h,T) - tNow);
                        end
                    end
                end
                
                if h == 1
                    % First, update the temperature of surface
                    modifiedDivergence = (t(x-1,y,h,T)-2*t(x,y,h,T)+t(x+1,y,h,T)) / (lengthX * lengthX) ...
                                        +(t(x,y-1,h,T)-2*t(x,y,h,T)+t(x,y+1,h,T)) / (lengthY * lengthY) ...
                                        +(-t(x,y,h,T)+t(x,y,h+1,T)-lengthH/kHeat*hCoefficient*(tNow-tAir)) / (lengthH * lengthH);
                    t(x, y, h, T+1) = t(x, y, h, T) + lengthT * alpha * modifiedDivergence + deltaT;
                else
                    % Next, update the temperature inside.
                    divergence = (t(x-1,y,h,T)-2*t(x,y,h,T)+t(x+1,y,h,T)) / (lengthX * lengthX) ...
                                +(t(x,y-1,h,T)-2*t(x,y,h,T)+t(x,y+1,h,T)) / (lengthY * lengthY) ...
                                +(t(x,y,h-1,T)-2*t(x,y,h,T)+t(x,y,h+1,T)) / (lengthH * lengthH);
                    t(x, y, h, T+1) = t(x, y, h, T) + lengthT * alpha * divergence + deltaT;
                end
            end
        end
    end

    t(bodyLeft:bodyRight, bodyFront:bodyBehind, bodyUp:bodyDown, T+1) = 37;
    % Update the boundary temperature. (For simplicity, we assume it is
    % equal to that of the neighborhood first.)

    % Next, because the temperature outside the bathtub is steady and
    % the temperature inside goes down slow, so we assume the wall of
    % the bathtub is in a steady state. Given that lambda of the wall is
    % 0.19 W/(m¡¤K), after getting the dT/dx we know the q of the left,
    % right, front, back, down side.
    t(1,:,:,T+1) = t(2,:,:,T+1) - alphaWall / lengthX * lengthT * (t(1,:,:,T) - tAir) / wSide;
    t(maxX,:,:,T+1) = t(maxX-1,:,:,T+1) - alphaWall / lengthX * lengthT * (t(maxX,:,:,T) - tAir) / wSide;
    t(:,1,:,T+1) = t(:,2,:,T+1) - alphaWall / lengthX * lengthT * (t(:,1,:,T) - tAir) / wSide;
    t(:,maxY,:,T+1) = t(:,maxY-1,:,T+1) - alphaWall / lengthX * lengthT * (t(:,maxY,:,T) - tAir) / wSide;
    t(:,:,maxH,T+1) = t(:,:,maxH-1,T+1) - alphaWall / lengthX * lengthT * (t(:,:,maxH,T) - tAir) / wDown;

    
end

a = zeros(maxH, maxT);
for i = 1:maxH
    for j = 1:maxT
        a(i,j)=t(10,10,i,j);
    end
end
mesh(lengthT*[1:maxT], lengthH*[1:maxH], a);
