f=open('rom.mif','r') 
w=open('rom.coe','w')
line = f.readline()
while line: 
    line =line.strip()
    print line
    w.write(line)
    w.write(',\n')
    line = f.readline()  