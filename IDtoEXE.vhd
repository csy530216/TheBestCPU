library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IDtoEXE is
	port(
		clk : in std_logic;
		clk25: in std_logic;
		rst : in std_logic;
		in_exe_alu1_operand1: in std_logic_vector(15 downto 0);
		in_exe_alu1_operand2: in std_logic_vector(15 downto 0);
		in_exe_alu1_opkind: in std_logic;
				
		in_exe_regwrite: in std_logic;
		in_exe_regdst: in std_logic_vector(3 downto 0);
		in_exe_memtoreg:in std_logic;
		
		in_exe_memwrite: in std_logic;
		in_exe_memwritedata : in std_logic_vector(15 downto 0);
		
		out_exe_alu1_operand1: out std_logic_vector(15 downto 0); 
		out_exe_alu1_operand2: out std_logic_vector(15 downto 0);
		out_exe_alu1_opkind: out std_logic;
		
		out_exe_regwrite: out std_logic;
		out_exe_regdst: out std_logic_vector(3 downto 0);
		out_exe_memtoreg: out std_logic;
		
		out_exe_memwrite: out std_logic;
		out_exe_memwritedata: out std_logic_vector(15 downto 0))
end IDtoEXE;
 
architecture Behavioral of IDtoEXE is
  
begin
	process (rst,clk)
	begin
		if (rst='0') then
			out_exe_alu1_operand1 <= (others => '0');
			out_exe_alu1_operand2 <= (others => '0');
			out_exe_alu1_opkind <= (others => '0');
			out_exe_regwrite <= '0';
			out_exe_regdst <= (others => '0');
			out_exe_memtoreg <= '0';
			out_exe_memwrite <= '0';
			out_exe_memwritedata <= (others => '0');
		elsif (rising_edge(clk) and clk25 = '0') then
			out_exe_alu1_operand1 <= in_exe_alu1_operand1;
			out_exe_alu1_operand2 <= in_exe_alu1_operand2;
			out_exe_alu1_opkind <= in_exe_alu1_opkind;
			out_exe_regwrite <= in_exe_regwrite;
			out_exe_regdst <= in_exe_regdst;
			out_exe_memtoreg <= in_exe_memtoreg;
			out_exe_memwrite <= in_exe_memwrite;
			out_exe_memwritedata <= in_exe_memwritedata;
		end if;
	end process;
end Behavioral;