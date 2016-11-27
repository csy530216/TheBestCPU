library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IDtoEXE is
 port(
		clk : in std_logic;
		rst : in std_logic;
		in_exe_alu1_operand1: in std_logic_vector(15 downto 0);
		in_exe_alu1_operand2: in std_logic_vector(15 downto 0);
		in_exe_alu1_opkind: in std_logic;
		
		in_exe_memwritedata : in std_logic_vector(15 downto 0);
		in_exe_regdst: in std_logic_vector(3 downto 0);
		in_exe_readno1: in std_logic_vector(3 downto 0);
		in_exe_readno2: in std_logic_vector(3 downto 0);
		
		in_exe_memwrite: in std_logic;
		in_exe_memtoreg:in std_logic;
		
		in_exe_regwrite: in std_logic;
		id_exe_isLW：in std_logic
		id_exe_regdst: in std_logic_vector(3 downto 0);
		
		out_exe_alu1_operand1: out std_logic_vector(15 downto 0); 
		out_exe_alu1_operand2: out std_logic_vector(15 downto 0);
		out_exe_alu1_opkind: out std_logic;
		out_exe_regwrite: out std_logic;
		out_exe_regdst: out std_logic_vector(3 downto 0);
		out_exe_memwrite: out std_logic;
		out_exe_memwritedata: out std_logic_vector(15 downto 0);
		out_exe_memtoreg: out std_logic;
		out_exe_readno1: out std_logic_vector(3 downto 0);
		out_exe_readno2: out std_logic_vector(3 downto 0);
		id_isLW:  out std_logic;
		id_regdst: out std_logic_vector(3 downto 0));
 end IDtoEXE;
 
 architecture Behavioral of IDtoEXE is
  
	shared variable	exe_alu1_oprand1 :  std_logic_vector(15 downto 0);
	shared variable	exe_alu1_oprand2 :  std_logic_vector(15 downto 0);
	shared variable	exe_alu1_opkind: in std_logic;
	shared variable	exe_memwritedata : in std_logic_vector(15 downto 0);
	shared variable	exe_regdst: in std_logic_vector(3 downto 0);
	shared variable	exe_readno1: in std_logic_vector(3 downto 0);
	shared variable	exe_readno2: in std_logic_vector(3 downto 0);
	shared variable	exe_memwrite: in std_logic;
	shared variable	exe_memtoreg:in std_logic;
	shared variable	exe_regwrite: in std_logic;
	shared variable	exe_isLW：in std_logic
	shared variable exe_id_regdst: in std_logic_vector(3 downto 0);
begin
process (rst,clk)
begin
	if (rst='0') then
	
		exe_alu1_oprand1 := "0000000000000000";
		exe_alu1_oprand2 := "0000000000000000";
		exe_alu1_opkind := '0';
		exe_memwritedata := "0000000000000000";
		exe_regdst :="0000";
		exe_readno1 :="0000";
		exe_readno2 :="0000";
		exe_memwrite := '0';
		exe_memtoreg := '0';
		exe_regwrite := '0';
		exe_isLW := '0';
		exe_id_regdst := "0000";
		
		elsif (clk'event and clk='1') then
			exe_alu1_oprand1 := in_exe_alu1_operand1;
			exe_alu1_oprand2:= in_exe_alu1_operand2;
			exe_alu1_opkind :=in_exe_alu1_opkind;
			exe_memwritedata :=in_exe_memwritedata;
			exe_regdst :=in_exe_regdst;
			exe_readno1 :=in_exe_readno1;
			exe_readno2 :=in_exe_readno2;
			exe_memwrite := in_exe_memwrite;
			exe_memtoreg :=in_exe_memtoreg;
			exe_regwrite :=in_exe_regwrite;
			exe_isLW :=id_exe_isLW;
			exe_id_regdst := id_exe_regdst;
		end if;
		
		out_exe_alu1_operand1 <= exe_alu1_oprand1;
		out_exe_alu1_operand2 <= exe_alu1_oprand2;
		out_exe_alu1_opkind <= exe_alu1_opkind;
		out_exe_regwrite <= exe_regwrite;
		out_exe_regdst <=exe_regdst;
		out_exe_memwrite <= exe_memwrite;
		out_exe_memwritedata <= exe_memwritedata;
		out_exe_memtoreg <= exe_memtoreg;
		out_exe_readno1 <= exe_readno1;
		out_exe_readno2 <= exe_readno2;
		id_isLW <= exe_isLW;
		id_regdst <= exe_id_regdst;
end process;
end Behavioral;

