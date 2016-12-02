----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:35:27 12/02/2016 
-- Design Name: 
-- Module Name:    FlashLoader - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FlashLoader is
    Port ( 
			clk:					in std_logic;
			rst:					in std_logic;
			start:					inout std_logic;
			
			flashData : 			inout  std_logic_vector(15 downto 0);
			flashAddr : 			out std_logic_vector(22 downto 0);
			flashByte:				out std_logic;
			flashVpen:				out std_logic;
			flashCE:				out std_logic;
			flashOE:				out std_logic;
			flashWE:				out std_logic;
			flashRP:				out std_logic;
			
			ifram2_en:				out std_logic;
			ifram2_oe:				out std_logic;
			ifram2_we:				out std_logic;
			ifram2_addr : 				out  STD_LOGIC_VECTOR (17 downto 0);
			ram2if_data : 				inout  STD_LOGIC_VECTOR (15 downto 0)		
	);
end FlashLoader;

architecture Behavioral of FlashLoader is

type status is (s0, s1, s2, s3, s4);
signal state : status := s0;
signal addr : std_logic_vector(15 downto 0) := (others => '0');
signal addr2: std_logic_vector(15 downto 0) := (others => '0');
signal datatmp : std_logic_vector(15 downto 0);

begin
	flashByte <= '1';
	flashVpen <= '1';
	flashWE <= '1';
	flashRP <= '1';
	ifram2_en <= '0';
	ifram2_oe <= '1';
	
	process (clk, rst)
	begin
		if rst = '0' then
			start <= '1';
			addr <= (others => '0');
			addr2<= (others => '0');
			flashCE <= '1';
			flashOE <= '1';
			state <= s0;
		elsif falling_edge(clk) then
			if start = '1' then
				flashCE <= '0';
				flashOE <= '0';
				if addr < "0000001100000000" then					---512+256	
					case state is
						when s0 =>
							--flashOE <= '0';
							flashData <= (others => 'Z');
							if_ram2_we <= '1';
							state <= s1;
						when s1 =>
							flashAddr(15 downto 0) <= addr2;
							flashAddr(22 downto 16) <= (others => '0');
							ifram2_addr(15 downto 0) <= addr;
							ifram2_addr(17 downto 16) <= "00";
							addr2<= addr2 + "10";
							addr <= addr + '1';
							state <= s2;
						when s2 =>
							datatmp <= flashData;
							state <= s3;
						when s3 =>
							ram2if_data <= datatmp;
							state <= s4;
						when s4 =>
							--flashOE <= '1';
							ram2_we <= '0';
							state <= s0;
						when others => 
							state <= s0;
					end case;
					start <= '1';
				else													-- addr
					start <= '0';
				end if;
			else														-- start = '0'
				flashCE <= '1';
				flashOE <= '1';
				ifram2_we <= '1';
				ifram2_addr <= (others => '1');
				ram2if_data <= (others => 'Z');
			end if;
		end if;
	end process;
end Behavioral;

