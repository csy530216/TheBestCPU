----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:54:44 11/27/2016 
-- Design Name: 
-- Module Name:    ID - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID is
    Port ( id_inst : in  STD_LOGIC_VECTOR (15 downto 0);
           id_pc : in  STD_LOGIC_VECTOR (15 downto 0);
           id_readdata1 : in  STD_LOGIC_VECTOR (15 downto 0);
           id_readdata2 : in  STD_LOGIC_VECTOR (15 downto 0);
           id_IH : in  STD_LOGIC_VECTOR (15 downto 0);
           id_SP : in  STD_LOGIC_VECTOR (15 downto 0);
           id_T : in  STD_LOGIC_VECTOR (15 downto 0);
           id_RA : in  STD_LOGIC_VECTOR (15 downto 0);
           id_isLW : in  STD_LOGIC;
           id_regdst : in  STD_LOGIC_VECTOR (3 downto 0);
           rst : in  STD_LOGIC;
			  
           exe_alu1_operand1 : out  STD_LOGIC_VECTOR (15 downto 0);
           exe_alu1_operand2 : out  STD_LOGIC_VECTOR (15 downto 0);
           exe_alu1_opkind : out  STD_LOGIC_VECTOR (3 downto 0);
           reg_readno1 : out  STD_LOGIC_VECTOR (3 downto 0);
           reg_readno2 : out  STD_LOGIC_VECTOR (3 downto 0);
           exe_readno1 : out  STD_LOGIC_VECTOR (3 downto 0);
           exe_readno2 : out  STD_LOGIC_VECTOR (3 downto 0);
           exe_regwrite : out  STD_LOGIC;
           exe_regdst : out  STD_LOGIC_VECTOR (3 downto 0);
           exe_memtoreg : out  STD_LOGIC;
           if_branchjump_ctr : out  STD_LOGIC_VECTOR (1 downto 0);
           if_branch : out  STD_LOGIC_VECTOR (15 downto 0);
           if_jump : out  STD_LOGIC_VECTOR (15 downto 0);
			  exe_memwrite : out  STD_LOGIC;
           exe_memwritedata : out  STD_LOGIC_VECTOR (15 downto 0);
           id_exe_isLW : out  STD_LOGIC;
           if_flush_from_id : out  STD_LOGIC;
           if_id_flush : out  STD_LOGIC);
end ID;

architecture Behavioral of ID is
	--ADDIU: RX, IMMEDIATE
	--ADDIU3: RX, IMMEDIATE
	--ADDSP: SP, IMMEDIATE
	--ADDU: RX, RY
	--AND: RX, RY
	--B: IMMEDIATE. Ìø×ª£¬Á¢¼´ÅÐ¶Ï
	--BEQZ: RX, IMMEDIATE. Ìø×ª£¬Á¢¼´ÅÐ¶Ï
	--BNEZ: RX, IMMEDIATE. Ìø×ª£¬Á¢¼´ÅÐ¶Ï
	--BTEQZ: T, IMMEDIATE. Ìø×ª£¬Á¢¼´ÅÐ¶Ï
	--BTNEZ: T, IMMEDIATE. Ìø×ª£¬Á¢¼´ÅÐ¶Ï
	--CMP: RX, RY
	--JALR: RX, RPC. Ìø×ª£¬Á¢¼´ÅÐ¶Ï. ÍùÇ°´«£ºRPC + 0
	--JR: RX. Ìø×ª£¬Á¢¼´ÅÐ¶Ï.
	--JRRA: RA. Ìø×ª£¬Á¢¼´ÅÐ¶Ï
	--LI: 0, IMMEDIATE
	--LW: RX, IMMEDIATE
	--LW_SP: SP, IMMEDIATE
	--MFIH: IH, 0
	--MFPC: PC, 0
	--MTIH: RX, 0
	--MTSP: RY, 0
	--NOT: RY, 0
	--OR: RX, RY
	--SLL: RY, IMMEDIATE
	--SLTUI: RX, IMMEDIATE
	--SRA: RY, IMMEDIATE
	--SUBU: RX, RY
	--SW: RX, IMMEDIATE  MEMWRITEDATA: RY
	--SW_RS: SP, IMMEDIATE  MEMWRITEDATA: RA
	--SW_SP: SP, IMMEDIATE  MEMWRITEDATA: RX
	
   signal readno1 : STD_LOGIC_VECTOR (3 downto 0) := "1111";
   signal readno2 : STD_LOGIC_VECTOR (3 downto 0) := "1111";
begin
	
	reg_readno1(3) <= '0';
	reg_readno1(2 downto 0) <= id_inst(10 downto 8);
	reg_readno2(3) <= '0';
	reg_readno2(2 downto 0) <= id_inst(7 downto 5);
	
	exe_alu1_operand1 <= id_readdata1 when id_inst(15 downto 11) = "01001" else	--ADDIU
	                     id_readdata1 when id_inst(15 downto 11) = "01000" else	--ADDIU3
								id_SP when id_inst(15 downto 8) = "01100011" else	--ADDSP
								id_readdata1 when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "01" else --ADDU
								id_readdata1 when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01100" else --AND
								"0000000000000000" when id_inst(15 downto 11) = "00010" else --B
								"0000000000000000" when id_inst(15 downto 11) = "00100" else --BEQZ
								"0000000000000000" when id_inst(15 downto 11) = "00101" else --BNEZ
								"0000000000000000" when id_inst(15 downto 8) = "01100000" else --BTEQZ
								"0000000000000000" when id_inst(15 downto 8) = "01100001" else --BTNEZ
								id_readdata1 when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01010" else --CMP
								id_pc + 2 when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "11000000" else --JALR
								"0000000000000000" when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "00000000" else --JR
								"0000000000000000" when id_inst(15 downto 0) = "1110100000100000" else --JRRA
								"0000000000000000" when id_inst(15 downto 11) = "01101" else --LI
								id_readdata1 when id_inst(15 downto 11) = "10011" else --LW
								id_SP when id_inst(15 downto 11) = "10010" else --LW_SP
								id_IH when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000000" else --MFIH
								id_pc when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "01000000" else --MFPC
								id_readdata1 when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000001" else --MTIH
								id_readdata2 when id_inst(15 downto 8) = "01100100" and id_inst(4 downto 0) = "00000" else --MTSP
								id_readdata2 when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01111" else --NOT
								id_readdata1 when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01101" else --OR
								id_readdata2 when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "00" else --SLL
								id_readdata1 when id_inst(15 downto 11) = "01011" else --SLTUI
								id_readdata2 when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "11" else --SRA
								id_readdata1 when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "11" else --SUBU
								id_readdata1 when id_inst(15 downto 11) = "11011" else --SW
								id_SP when id_inst(15 downto 8) = "01100010" else --SW_RS
								id_SP when id_inst(15 downto 11) = "11010" else --SW_SP
								"0000000000000000";
	
	readno1 		      <= "0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "01001" else	--ADDIU
	                     "0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "01000" else	--ADDIU3
								"1000" when id_inst(15 downto 8) = "01100011" else	--ADDSP
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "01" else --ADDU
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01100" else --AND
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "00100" else --BEQZ
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "00101" else --BNEZ
								"1010" when id_inst(15 downto 8) = "01100000" else --BTEQZ
								"1010" when id_inst(15 downto 8) = "01100001" else --BTNEZ
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01010" else --CMP
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "10011" else --LW
								"1000" when id_inst(15 downto 11) = "10010" else --LW_SP
								"1001" when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000000" else --MFIH
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000001" else --MTIH
								"0" & id_inst(7 downto 5) when id_inst(15 downto 8) = "01100100" and id_inst(4 downto 0) = "00000" else --MTSP
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01111" else --NOT
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01101" else --OR
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "00" else --SLL
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "01011" else --SLTUI
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "11" else --SRA
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "11" else --SUBU
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11011" else --SW
								"1000" when id_inst(15 downto 8) = "01100010" else --SW_RS
								"1000" when id_inst(15 downto 11) = "11010" else --SW_SP
								"1111";
	
	exe_readno1			<= readno1;

	exe_alu1_operand2 <= std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 11) = "01001" else	--ADDIU
	                     std_logic_vector(resize(signed(id_inst(3 downto 0)), 16)) when id_inst(15 downto 11) = "01000" else	--ADDIU3
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 8) = "01100011" else	--ADDSP
								id_readdata2 when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "01" else --ADDU
								id_readdata2 when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01100" else --AND
								"0000000000000000" when id_inst(15 downto 11) = "00010" else --B
								"0000000000000000" when id_inst(15 downto 11) = "00100" else --BEQZ
								"0000000000000000" when id_inst(15 downto 11) = "00101" else --BNEZ
								"0000000000000000" when id_inst(15 downto 8) = "01100000" else --BTEQZ
								"0000000000000000" when id_inst(15 downto 8) = "01100001" else --BTNEZ
								id_readdata2 when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01010" else --CMP
								"0000000000000000" when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "11000000" else --JALR
								"0000000000000000" when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "00000000" else --JR
								"0000000000000000" when id_inst(15 downto 0) = "1110100000100000" else --JRRA
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 11) = "01101" else --LI
								std_logic_vector(resize(signed(id_inst(4 downto 0)), 16)) when id_inst(15 downto 11) = "10011" else --LW
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 11) = "10010" else --LW_SP
								"0000000000000000" when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000000" else --MFIH
								"0000000000000000" when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "01000000" else --MFPC
								"0000000000000000" when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000001" else --MTIH
								"0000000000000000" when id_inst(15 downto 8) = "01100100" and id_inst(4 downto 0) = "00000" else --MTSP
								"0000000000000000" when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01111" else --NOT
								id_readdata2 when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01101" else --OR
								std_logic_vector(resize(signed(id_inst(4 downto 2)), 16)) when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "00" else --SLL
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 11) = "01011" else --SLTUI
								std_logic_vector(resize(signed(id_inst(4 downto 2)), 16)) when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "11" else --SRA
								id_readdata2 when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "11" else --SUBU
								std_logic_vector(resize(signed(id_inst(4 downto 0)), 16)) when id_inst(15 downto 11) = "11011" else --SW
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 8) = "01100010" else --SW_RS
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 11) = "11010" else --SW_SP
								"0000000000000000";
								
	readno2			   <= "0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "01" else --ADDU
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01100" else --AND
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01010" else --CMP
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01101" else --OR
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "11" else --SUBU
								"1111";
								
	exe_readno2			<= readno2;
								
	exe_regwrite     	<= '1' when id_inst(15 downto 11) = "01001" else	--ADDIU
	                     '1' when id_inst(15 downto 11) = "01000" else	--ADDIU3
								'1' when id_inst(15 downto 8) = "01100011" else	--ADDSP
								'1' when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "01" else --ADDU
								'1' when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01100" else --AND
								'1' when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01010" else --CMP
								'1' when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "11000000" else --JALR
								'1' when id_inst(15 downto 11) = "01101" else --LI
								'1' when id_inst(15 downto 11) = "10011" else --LW
								'1' when id_inst(15 downto 11) = "10010" else --LW_SP
								'1' when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000000" else --MFIH
								'1' when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "01000000" else --MFPC
								'1' when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000001" else --MTIH
								'1' when id_inst(15 downto 8) = "01100100" and id_inst(4 downto 0) = "00000" else --MTSP
								'1' when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01111" else --NOT
								'1' when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01101" else --OR
								'1' when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "00" else --SLL
								'1' when id_inst(15 downto 11) = "01011" else --SLTUI
								'1' when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "11" else --SRA
								'1' when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "11" else --SUBU
								'0';
	
	exe_regdst        <= "0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "01001" else	--ADDIU
	                     "0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "01000" else	--ADDIU3
								"1000" when id_inst(15 downto 8) = "01100011" else	--ADDSP
								"0" & id_inst(4 downto 2) when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "01" else --ADDU
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01100" else --AND
								"1010" when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01010" else --CMP
								"1011" when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "11000000" else --JALR
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "01101" else --LI
								"0" & id_inst(7 downto 5) when id_inst(15 downto 11) = "10011" else --LW
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "10010" else --LW_SP
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000000" else --MFIH
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "01000000" else --MFPC
								"1001" when id_inst(15 downto 11) = "11110" and id_inst(7 downto 0) = "00000001" else --MTIH
								"1000" when id_inst(15 downto 8) = "01100100" and id_inst(4 downto 0) = "00000" else --MTSP
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01111" else --NOT
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "11101" and id_inst(4 downto 0) = "01101" else --OR
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "00" else --SLL
								"1010" when id_inst(15 downto 11) = "01011" else --SLTUI
								"0" & id_inst(10 downto 8) when id_inst(15 downto 11) = "00110" and id_inst(1 downto 0) = "11" else --SRA
								"0" & id_inst(4 downto 2) when id_inst(15 downto 11) = "11100" and id_inst(1 downto 0) = "11" else --SUBU
								"1111";
								
	exe_memtoreg      <= '1' when id_inst(15 downto 11) = "10011" else --LW
								'1' when id_inst(15 downto 11) = "10010" else --LW_SP
								'0';
								
	id_exe_isLW       <= '1' when id_inst(15 downto 11) = "10011" else --LW
								'1' when id_inst(15 downto 11) = "10010" else --LW_SP
								'0';
								
	exe_memwrite      <= '1' when id_inst(15 downto 11) = "11011" else --SW
								'1' when id_inst(15 downto 8) = "01100010" else --SW_RS
								'1' when id_inst(15 downto 11) = "11010" else --SW_SP
								'0';
								
	exe_memwritedata  <= id_readdata2 when id_inst(15 downto 11) = "11011" else --SW
								id_RA when id_inst(15 downto 8) = "01100010" else --SW_RS
								id_readdata1 when id_inst(15 downto 11) = "11010" else --SW_SP
								"0000000000000000";
	
	if_branchjump_ctr	<= "01" when id_inst(15 downto 11) = "00010" else --B
								"01" when id_inst(15 downto 11) = "00100" and id_readdata1 = "0000000000000000" else --BEQZ
								"01" when id_inst(15 downto 11) = "00101" and id_readdata1 /= "0000000000000000" else --BNEZ
								"01" when id_inst(15 downto 8) = "01100000" and id_T = "0000000000000000" else --BTEQZ
								"01" when id_inst(15 downto 8) = "01100001" and id_T /= "0000000000000000" else --BTNEZ
								"10" when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "11000000" else --JALR
								"10" when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "00000000" else --JR
								"10" when id_inst(15 downto 0) = "1110100000100000" else --JRRA
								"00";
	
	if_branch      	<= std_logic_vector(resize(signed(id_inst(10 downto 0)), 16)) when id_inst(15 downto 11) = "00010" else --B
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 11) = "00100" else --BEQZ
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 11) = "00101" else --BNEZ
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 8) = "01100000" else --BTEQZ
								std_logic_vector(resize(signed(id_inst(7 downto 0)), 16)) when id_inst(15 downto 8) = "01100001" else --BTNEZ
								"0000000000000000";
								
	if_jump  			<= id_readdata1 when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "11000000" else --JALR
								id_readdata1 when id_inst(15 downto 11) = "11101" and id_inst(7 downto 0) = "00000000" else --JR
								id_RA when id_inst(15 downto 0) = "1110100000100000" else --JRRA
								"0000000000000000";
								
	if_id_flush			<= '1' when id_isLW = '1' and ( (id_regdst = readno1) or (id_regdst = readno2) ) else
								'0';
								
end Behavioral;

