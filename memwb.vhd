----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:15:42 11/27/2016 
-- Design Name: 
-- Module Name:    memwb - Behavioral 
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

entity memwb is
port(
	clk: in std_logic;
	clk25: in std_logic;
	rst: in std_logic;
	in_wb_data:in std_logic_vector(15 downto 0); --写回寄存器的数据
	in_wb_regwrite:in std_logic; --是否需要写入寄存器
	in_wb_regdst:in std_logic_vector(3 downto 0); --写入哪个寄存器
	out_wb_data:out std_logic_vector(15 downto 0); --写回寄存器的数据
	out_wb_regwrite:out std_logic; --是否需要写入寄存器
	out_wb_regdst:out std_logic_vector(3 downto 0); --写入哪个寄存器
	mem_wb_data:out std_logic_vector(15 downto 0); --写回寄存器的数据
	mem_wb_regwrite:out std_logic; --是否需要写入寄存器
	mem_wb_regdst:out std_logic_vector(3 downto 0) --写入哪个寄存器
);
end memwb;

architecture Behavioral of memwb is

begin
	process(clk)
	begin
		if (rising_edge(clk) and clk25 = '0') then
			out_wb_data<=in_wb_data;
			out_wb_regwrite<=in_wb_regwrite;
			out_wb_regdst<=in_wb_regdst;
			mem_wb_data<=in_wb_data;
			mem_wb_regwrite<=in_wb_regwrite;
			mem_wb_regdst<=in_wb_regdst;
		end if;
	end process;
end Behavioral;

