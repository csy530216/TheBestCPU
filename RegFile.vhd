library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegFile is
	port(
			clk : in std_logic;
			clk25 : in std_logic;
			rst : in std_logic;
			
			reg_readno1 : in std_logic_vector(3 downto 0);
			reg_readno2 : in std_logic_vector(3 downto 0);
			
			reg_writeno	 : in std_logic_vector(3 downto 0);
			reg_writedata : in std_logic_vector(15 downto 0);
			reg_we : in std_logic;
			
			id_readdata1 : out std_logic_vector(15 downto 0);
			id_readdata2 : out std_logic_vector(15 downto 0);
			id_T : out std_logic_vector(15 downto 0);
			id_SP : out std_logic_vector(15 downto 0);
			id_IH : out std_logic_vector(15 downto 0);
			id_RA : out std_logic_vector(15 downto 0)
	);
end RegFile;

architecture Behavioral of RegFile is

	signal r0 : std_logic_vector(15 downto 0);
	signal r1 : std_logic_vector(15 downto 0);
	signal r2 : std_logic_vector(15 downto 0);
	signal r3 : std_logic_vector(15 downto 0);
	signal r4 : std_logic_vector(15 downto 0);
	signal r5 : std_logic_vector(15 downto 0);
	signal r6 : std_logic_vector(15 downto 0);
	signal r7 : std_logic_vector(15 downto 0);
	signal T : std_logic_vector(15 downto 0);
	signal IH : std_logic_vector(15 downto 0);
	signal SP : std_logic_vector(15 downto 0);
	signal RA : std_logic_vector(15 downto 0);
begin
	
	process(clk, rst)
	begin
		if (rst = '0') then
			r0 <= (others => '0');
			r1 <= (others => '0');
			r2 <= (others => '0');
			r3 <= (others => '0');
			r4 <= (others => '0');
			r5 <= (others => '0');
			r6 <= (others => '0');
			r7 <= (others => '0');
			T <= (others => '0');
			IH <= (others => '0');			
			SP <= (others => '0');
			RA <= (others =>'0');
		elsif (rising_edge(clk) and clk25 = '1' and reg_we = '1') then
			case reg_writeno is 
				when "0000" => r0 <= reg_writedata;
				when "0001" => r1 <= reg_writedata;
				when "0010" => r2 <= reg_writedata;
				when "0011" => r3 <= reg_writedata;
				when "0100" => r4 <= reg_writedata;
				when "0101" => r5 <= reg_writedata;
				when "0110" => r6 <= reg_writedata;
				when "0111" => r7 <= reg_writedata;
				when "1000" => SP <= reg_writedata;
				when "1001" => IH <= reg_writedata;
				when "1010" => T <= reg_writedata;
				when "1011" => RA <=reg_writedata;
				when others =>
			end case;
		end if;
	end process;
	
	process
	begin 
		case '0' & reg_readno1 is 
			when "0000" => id_readdata1 <= r0;
			when "0001" => id_readdata1 <= r1;
			when "0010" => id_readdata1 <= r2;
			when "0011" => id_readdata1 <= r3;
			when "0100" => id_readdata1 <= r4;
			when "0101" => id_readdata1 <= r5;
			when "0110" => id_readdata1 <= r6;
			when "0111" => id_readdata1 <= r7;
			when others =>
		end case;
	end process;
	
	process
	begin 
		case '0' & reg_readno2 is
			when "0000" => id_readdata2 <= r0;
			when "0001" => id_readdata2 <= r1;
			when "0010" => id_readdata2 <= r2;
			when "0011" => id_readdata2 <= r3;
			when "0100" => id_readdata2 <= r4;
			when "0101" => id_readdata2 <= r5;
			when "0110" => id_readdata2 <= r6;
			when "0111" => id_readdata2 <= r7;
			when others =>
		end case;
	end process;
	
	id_SP <= SP;
	id_IH <= IH;
	id_T <= T;
	id_RA <= RA;
	
end Behavioral;