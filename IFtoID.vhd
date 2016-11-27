----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:19:25 11/27/2016 
-- Design Name: 
-- Module Name:    IFtoID - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFtoID is
    Port ( in_id_inst : in  STD_LOGIC_VECTOR (15 downto 0);
           in_id_pc : in  STD_LOGIC_VECTOR (15 downto 0);
           if_id_flush : in  STD_LOGIC;
			  clk: in  STD_LOGIC;
			  clk25: in  STD_LOGIC;
			  rst: in  STD_LOGIC;
           out_id_inst : out  STD_LOGIC_VECTOR (15 downto 0);
           out_id_pc : out  STD_LOGIC_VECTOR (15 downto 0));
end IFtoID;

architecture Behavioral of IFtoID is

begin
	process (clk)
	begin
		if rising_edge(clk) then
			if clk25 = '0' then
				if if_id_flush = '0' then
					out_id_inst <= in_id_inst;
					out_id_pc <= in_id_pc;
				end if;
			end if;
		end if;
	end process;

end Behavioral;

