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
	exe_readno1 : in std_logic_vector(3 downto 0);
	exe_readno2 : in std_logic_vector(3 downto 0);
	exe_mem_wboraddr : in std_logic_vector(15 downto 0);
	exe_mem_regwrite : in std_logic;
	exe_mem_regdst : in std_logic_vector(3 downto 0);
	mem_wb_data : in std_logic_vector(15 downto 0);
	mem_wb_regwrite : in std_logic;
	mem_wb_regdst : in std_logic_vector(3 downto 0);
	
	mem_regwrite : out std_logic;
	mem_regdst : out std_logic_vector(3 downto 0);
	mem_wboraddr : out std_logic_vector(15 downto 0);
	mem_memwrite : out std_logic;
	mem_memwritedata : out std_logic_vector(15 downto 0);
	mem_memtoreg : out std_logic;
	if_wboraddr : out std_logic_vector(15 downto 0);
	if_flush_from_exe : out std_logic
);

architecture Behavioral of EXE is

begin  
	if(rst ='0') then
	exe_alu1_operand1="0000000000000000";
	exe_alu1_operand2="0000000000000000";
	exe_alu1_opkind="0000";
	exe_regwrite='0';
	exe_regdst="0000";
	exe_memwrite='0';
	exe_memwritedata="0000000000000000";
	exe_memtoreg='0';
	exe_readno1="0000";
	exe_readno2="0000";
	exe_mem_wboraddr="0000000000000000";
	exe_mem_regwrite='0';
	exe_mem_regdst="0000";
	mem_wb_data="0000000000000000";
	mem_wb_regwrite='0';
	mem_wb_regdst="0000";
	end if;
	process(exe_alu1_operand1 , exe_alu1_operand2, exe_alu1_opkind)
	begin
	
		Case exe_alu1_opkind is
			when "0000" =>	-- ADD
				mem_wboraddr <= exe_alu1_operand1 + exe_alu1_operand2;
				
			when "0001" =>	-- SUB
				mem_wboraddr <= exe_alu1_operand1 - exe_alu1_operand2;
				
			when "0010" =>	-- AND
				mem_wboraddr <= exe_alu1_operand1 and exe_alu1_operand2;
				
			when "0011" =>	-- OR
				mem_wboraddr <= exe_alu1_operand1 or exe_alu1_operand2;
				
			when "0100" =>	-- SLL
				mem_wboraddr <= to_stdlogicvector(to_bitvector(exe_alu1_operand1) sll position);
				
			when "0101" =>	-- SRA
				mem_wboraddr <= to_stdlogicvector(to_bitvector(exe_alu1_operand1) sra position);
				
			when "0110" =>	-- CMP
				if (exe_alu1_operand1 = exe_alu1_operand2) then
					mem_wboraddr <= (Others => '0');
				else
					mem_wboraddr <= "0000000000000001";
				end if;
				
			when "0111" =>	-- SLT
				if (exe_alu1_operand1 < exe_alu1_operand2) then
					mem_wboraddr <= "0000000000000001";
				else
					mem_wboraddr <= (Others => '0');
				end if;
				
			when "1000" =>	-- CMPF
				if (exe_alu1_operand1 = exe_alu1_operand2) then
					mem_wboraddr <= "0000000000000001";
					
				else
					mem_wboraddr <= (Others => '0');
	
				end if;
				
			when others=>	
				mem_wboraddr <= "0000000000000000";
		end case;   
		mem_regwrite <= exe_regwrite;
		mem_regdst <= exe_regdst;
		mem_memwrite <=exe_memwrite;
		mem_memwritedata <= exe_memwritedata;
		mem_memtoreg <=exe_memtoreg;
		if_wboraddr<= mem_wboraddr;
		
	end process;
	
	process