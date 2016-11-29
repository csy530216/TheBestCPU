----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:45:56 11/26/2016 
-- Design Name: 
-- Module Name:    exemem - Behavioral 
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

entity exemem is
port(
	clk: in std_logic;
	clk25: in std_logic;
	rst: in std_logic;
	in_mem_regwrite: in std_logic;  --是否需要写入寄存器
	in_mem_regdst:   in std_logic_vector(3 downto 0);  --写入哪个寄存器
	in_mem_wboraddr: in std_logic_vector(15 downto 0); --ALU1计算的结果
	in_mem_memwrite: in std_logic;  --是否SW
	in_mem_memwritedata: in std_logic_vector(15 downto 0);  --写入内存的内容
	in_mem_memtoreg: in std_logic;  --写回的内容是来自ALU的输出还是访存得到的数据
	out_mem_regwrite: out std_logic; --是否需要写入寄存器
	out_mem_regdst: out std_logic_vector(3 downto 0); --写入哪个寄存器
	out_mem_wboraddr:	out std_logic_vector(15 downto 0); --ALU1计算的结果
	out_mem_memwrite: out std_logic;  --是否SW
	out_mem_memwritedata: out std_logic_vector(15 downto 0);  --写入内存的内容
	out_mem_memtoreg: out std_logic  --写回的内容是来自ALU的输出还是访存得到的数据
);
end exemem;

architecture Behavioral of exemem is

begin
	process(clk)
	begin
		if (rising_edge(clk) and clk25 = '0') then
			out_mem_regwrite <= in_mem_regwrite;
			out_mem_regdst <= in_mem_regdst;
			out_mem_wboraddr <= in_mem_wboraddr;
			out_mem_memwrite <= in_mem_memwrite;
			out_mem_memwritedata <= in_mem_memwritedata;
			out_mem_memtoreg <= in_mem_memtoreg;
		end if;
	end process;
end Behavioral;

