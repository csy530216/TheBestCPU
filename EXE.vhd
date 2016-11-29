library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EXE is
	port(
		rst : in std_logic;
		exe_alu1_operand1 : in std_logic_vector(15 downto 0);
		exe_alu1_operand2 : in std_logic_vector(15 downto 0);
		exe_alu1_opkind : in std_logic_vector(3 downto 0);
		exe_regwrite : in std_logic;
		exe_regdst : in std_logic_vector(3 downto 0);
		exe_memwrite : in std_logic;
		exe_memwritedata : in std_logic_vector(15 downto 0);
		exe_memtoreg : in std_logic;
		
		mem_regwrite : out std_logic;
		mem_regdst : out std_logic_vector(3 downto 0);
		mem_wboraddr : out std_logic_vector(15 downto 0);
		mem_memwrite : out std_logic;
		mem_memwritedata : out std_logic_vector(15 downto 0);
		mem_memtoreg : out std_logic;
		if_wboraddr : out std_logic_vector(15 downto 0);
		if_flush_from_exe : out std_logic;
		
		id_regwrite_from_exe: out std_logic;
		id_regwritedata_from_exe: out std_logic_vector(15 downto 0);
		id_regdst_from_exe: out std_logic_vector(3 downto 0);
		id_isLW_from_exe: out std_logic
		
	);
end EXE;

architecture Behavioral of EXE is
signal wboraddr: std_logic_vector(15 downto 0) := (others=>'0');
begin  

	wboraddr <= exe_alu1_operand1 + exe_alu1_operand2 when exe_alu1_opkind="0000" else -- ADD
					exe_alu1_operand1 - exe_alu1_operand2 when exe_alu1_opkind="0001" else -- SUB
					exe_alu1_operand1 and exe_alu1_operand2 when exe_alu1_opkind="0010" else -- AND
					exe_alu1_operand1 or exe_alu1_operand2 when exe_alu1_opkind="0011" else	-- OR
					"0000000000000000" when exe_alu1_operand1 = exe_alu1_operand2 and exe_alu1_opkind="0110" else--CMP
					"0000000000000001" when exe_alu1_operand1 /= exe_alu1_operand2 and exe_alu1_opkind="0110" else --CMP
					not exe_alu1_operand1 when exe_alu1_opkind="1001" else --NOT
					to_stdlogicvector(to_bitvector(exe_alu1_operand1) sll 8) when exe_alu1_operand2 ="0000000000000000" and exe_alu1_opkind="0100" else --SLL
					to_stdlogicvector(to_bitvector(exe_alu1_operand1) sll CONV_INTEGER(exe_alu1_operand2)) when exe_alu1_opkind="0100" else--SLL
					to_stdlogicvector(to_bitvector(exe_alu1_operand1) sra 8) when exe_alu1_operand2 ="0000000000000000" and exe_alu1_opkind="0101" else --SRA
					to_stdlogicvector(to_bitvector(exe_alu1_operand1) sra CONV_INTEGER(exe_alu1_operand2)) when exe_alu1_opkind="0101" else --SRA
					"0000000000000001" when exe_alu1_operand1 < exe_alu1_operand2 and exe_alu1_opkind="0111" else --SLTUI
					"0000000000000000" when exe_alu1_opkind="0111" else--SLTUI
					"0000000000000000";
								 
		
	if_flush_from_exe <= '1' when wboraddr(15)='1' and (exe_memtoreg='1' or exe_memwrite= '1') else
							   '0';

	mem_regwrite <= exe_regwrite;
	mem_regdst <= exe_regdst;
	mem_memwrite <= exe_memwrite;
	mem_memwritedata <= exe_memwritedata;
	mem_memtoreg <= exe_memtoreg;
	if_wboraddr <= wboraddr;
	mem_wboraddr <= wboraddr;
	
	id_regwrite_from_exe <= exe_regwrite;
	id_regwritedata_from_exe <= wboraddr;
	id_regdst_from_exe <= exe_regdst;
	id_isLW_from_exe <= exe_memtoreg;
	
end Behavioral;