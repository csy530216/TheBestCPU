----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:31:49 11/27/2016 
-- Design Name: 
-- Module Name:    wb - Behavioral 
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

entity wb is
port(
	wb_data:in std_logic_vector(15 downto 0); --写回寄存器的数据
	wb_regwrite:in std_logic; --是否需要写入寄存器
	wb_regdst:in std_logic_vector(3 downto 0); --写入哪个寄存器
	rst:in std_logic;
	reg_writedata:out std_logic_vector(15 downto 0); --写回寄存器的数据
	reg_we:out std_logic; --是否需要写入寄存器
	reg_writeno:out std_logic_vector(3 downto 0) --写入哪个寄存器
);
end wb;

architecture Behavioral of wb is
begin
	process(rst, wb_data, wb_regwrite, wb_regdst)
	begin
		if (rst='0') then
			reg_we <= '0';
			reg_writeno <= "1111";
			reg_writedata <= (others => '0');
		else
			reg_we <= wb_regwrite;
			reg_writeno <= wb_regdst;
			reg_writedata <= wb_data;
		end if;
	end process;
end Behavioral;

