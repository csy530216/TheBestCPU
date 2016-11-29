----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:53:20 11/19/2015 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
	port(
		clk_co:					in std_logic;
		clk_s:					in std_logic;
		rst:					in std_logic;
		
		ram1_en:				out std_logic;
		ram1_oe:				out std_logic;
		ram1_we:				out std_logic;
		ram1addr:				out std_logic_vector(17 downto 0);
		ram1data:				inout std_logic_vector(15 downto 0);
		
		ram2_en:				out std_logic;
		ram2_oe:				out std_logic;
		ram2_we:				out std_logic;
		ram2addr : 				out  STD_LOGIC_VECTOR (17 downto 0);
		ram2data : 				inout  STD_LOGIC_VECTOR (15 downto 0);
		data_ready : 			in  STD_LOGIC;
        tbre : 					in  STD_LOGIC;
        tsre : 					in  STD_LOGIC;
		rdn : 					out  STD_LOGIC;
        wrn : 					out  STD_LOGIC;
		
		flashData : 			inout  std_logic_vector(15 downto 0);
		flashAddr : 			out std_logic_vector(22 downto 0);
		flashByte:				out std_logic;
		flashVpen:				out std_logic;
		flashCE:				out std_logic;
		flashOE:				out std_logic;
		flashWE:				out std_logic;
		flashRP:				out std_logic;
		
		
		key_datain:				in std_logic;
		key_clkin:				in std_logic;
		
		light:					out std_logic_vector(15 downto 0);
		SW:						in std_logic_vector(15 downto 0);
		seg_h:					out std_logic_vector(6 downto 0);
		seg_l:					out std_logic_vector(6 downto 0)
	);
end CPU;

architecture Behavioral of CPU is

	COMPONENT EXE
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
			mem_wb_data : in std_logic_vector(15 downto 0);
			mem_wb_regwrite : in std_logic;
			mem_wb_regdst : in std_logic_vector(3 downto 0);
			exe_isLW: in std_logic;
			
			mem_regwrite : out std_logic;
			mem_regdst : out std_logic_vector(3 downto 0);
			mem_wboraddr : out std_logic_vector(15 downto 0);
			mem_memwrite : out std_logic;
			mem_memwritedata : out std_logic_vector(15 downto 0);
			mem_memtoreg : out std_logic;
			if_wboraddr : out std_logic_vector(15 downto 0);
			if_flush_from_exe : out std_logic;
			
			id_regwrite_from_exe: out std_logic;
			id_regdst_from_exe: out std_logic_vector(3 downto 0);
			id_isLW_from_exe: out std_logic
		);
	end COMPONENT;

	COMPONENT IDtoEXE
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
			out_exe_memwritedata: out std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ID
    Port ( 
			  id_inst : in  STD_LOGIC_VECTOR (15 downto 0);
           id_pc : in  STD_LOGIC_VECTOR (15 downto 0);
           id_readdata1 : in  STD_LOGIC_VECTOR (15 downto 0);
           id_readdata2 : in  STD_LOGIC_VECTOR (15 downto 0);
           id_IH : in  STD_LOGIC_VECTOR (15 downto 0);
           id_SP : in  STD_LOGIC_VECTOR (15 downto 0);
           id_T : in  STD_LOGIC_VECTOR (15 downto 0);
           id_RA : in  STD_LOGIC_VECTOR (15 downto 0);
           rst : in  STD_LOGIC;
			  
           exe_alu1_operand1 : out  STD_LOGIC_VECTOR (15 downto 0);
           exe_alu1_operand2 : out  STD_LOGIC_VECTOR (15 downto 0);
           exe_alu1_opkind : out  STD_LOGIC_VECTOR (3 downto 0);
           reg_readno1 : out  STD_LOGIC_VECTOR (3 downto 0);
           reg_readno2 : out  STD_LOGIC_VECTOR (3 downto 0);
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
           if_id_flush : out  STD_LOGIC;
			  
		     id_regwrite_from_exe : in  STD_LOGIC;
           id_regwritedata_from_exe : in  STD_LOGIC_VECTOR (15 downto 0);
           id_regdst_from_exe : in  STD_LOGIC_VECTOR (3 downto 0);
           id_isLW_from_exe : in  STD_LOGIC;
           id_regwrite_from_mem : in  STD_LOGIC;
           id_regwritedata_from_mem : in  STD_LOGIC_VECTOR (15 downto 0);
           id_regdst_from_mem : in  STD_LOGIC_VECTOR (3 downto 0)
	);		   
	END COMPONENT;
	
	COMPONENT InstructionFetch
    Port ( if_branch : in  STD_LOGIC_VECTOR (15 downto 0);
	        if_jump: in  STD_LOGIC_VECTOR (15 downto 0);
           if_branchjump_ctr : in  STD_LOGIC_VECTOR(1 downto 0);
           if_flush_from_id : in  STD_LOGIC;
           if_flush_from_exe : in  STD_LOGIC;
           if_wboraddr : in  STD_LOGIC_VECTOR (15 downto 0);
           if_memwrite : in  STD_LOGIC;
			  if_memwritedata : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
			  clk25 : in STD_LOGIC;	--clk25��һ��״̬��clk25 = '0' ��ʾ��ˮ�����ڵ�������
           rst : in  STD_LOGIC;
           id_inst : out  STD_LOGIC_VECTOR (15 downto 0);
           id_pc : out  STD_LOGIC_VECTOR (15 downto 0);
           ram2_we : out  STD_LOGIC;
           ram2_oe : out  STD_LOGIC;
           ram2_en : out  STD_LOGIC;
           ram2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
			  ram2_data : inout  STD_LOGIC_VECTOR (15 downto 0);
           mem_inst : out  STD_LOGIC_VECTOR (15 downto 0));
	end COMPONENT;
	
	COMPONENT IFtoID
    Port ( in_id_inst : in  STD_LOGIC_VECTOR (15 downto 0);
           in_id_pc : in  STD_LOGIC_VECTOR (15 downto 0);
           if_id_flush : in  STD_LOGIC;
			  clk: in  STD_LOGIC;
			  clk25: in  STD_LOGIC;
			  rst: in  STD_LOGIC;
           out_id_inst : out  STD_LOGIC_VECTOR (15 downto 0);
           out_id_pc : out  STD_LOGIC_VECTOR (15 downto 0));
	end COMPONENT;
	
	COMPONENT RegFile
	port(
			clk : in std_logic;
			clk25 : in std_logic;
			rst : in std_logic;
			
			reg_readno1 : in std_logic_vector(3 downto 0);
			reg_readno2 : in std_logic_vector(3 downto 0);
			
			reg_writeno	 : in std_logic_vector(3 downto 0);
			reg_writedata : in std_logic_vector(15 downto 0);
			reg_we : in std_logic;
			
			id_readdata1 : out std_logic_vector(15 downto 0);
			id_readdata2 : out std_logic_vector(15 downto 0);
			id_T : out std_logic_vector(15 downto 0);
			id_SP : out std_logic_vector(15 downto 0);
			id_IH : out std_logic_vector(15 downto 0);
			id_RA : out std_logic_vector(15 downto 0)
	);
	end COMPONENT;
	
	COMPONENT exemem
	port(
		clk: in std_logic;
		clk25: in std_logic;
		rst: in std_logic;
		in_mem_regwrite: in std_logic;  --�Ƿ���Ҫд��Ĵ���
		in_mem_regdst:   in std_logic_vector(3 downto 0);  --д���ĸ��Ĵ���
		in_mem_wboraddr: in std_logic_vector(15 downto 0); --ALU1����Ľ��
		in_mem_memwrite: in std_logic;  --�Ƿ�SW
		in_mem_memwritedata: in std_logic_vector(15 downto 0);  --д���ڴ������
		in_mem_memtoreg: in std_logic;  --д�ص�����������ALU��������Ƿô�õ�������
		out_mem_regwrite: out std_logic; --�Ƿ���Ҫд��Ĵ���
		out_mem_regdst: out std_logic_vector(3 downto 0); --д���ĸ��Ĵ���
		out_mem_wboraddr:	out std_logic_vector(15 downto 0); --ALU1����Ľ��
		out_mem_memwrite: out std_logic;  --�Ƿ�SW
		out_mem_memwritedata: out std_logic_vector(15 downto 0);  --д���ڴ������
		out_mem_memtoreg: out std_logic;  --д�ص�����������ALU��������Ƿô�õ�������
		exe_mem_wboraddr:	out std_logic_vector(15 downto 0); --ALU1����Ľ��
		exe_mem_regwrite: out std_logic; --�Ƿ���Ҫд��Ĵ���
		exe_mem_regdst: out std_logic_vector(3 downto 0) --д���ĸ��Ĵ���
	);
	end COMPONENT;
	
	COMPONENT memwb
	port(
		clk: in std_logic;
		clk25: in std_logic;
		rst: in std_logic;
		in_wb_data:in std_logic_vector(15 downto 0); --д�ؼĴ���������
		in_wb_regwrite:in std_logic; --�Ƿ���Ҫд��Ĵ���
		in_wb_regdst:in std_logic_vector(3 downto 0); --д���ĸ��Ĵ���
		out_wb_data:out std_logic_vector(15 downto 0); --д�ؼĴ���������
		out_wb_regwrite:out std_logic; --�Ƿ���Ҫд��Ĵ���
		out_wb_regdst:out std_logic_vector(3 downto 0); --д���ĸ��Ĵ���
		mem_wb_data:out std_logic_vector(15 downto 0); --д�ؼĴ���������
		mem_wb_regwrite:out std_logic; --�Ƿ���Ҫд��Ĵ���
		mem_wb_regdst:out std_logic_vector(3 downto 0) --д���ĸ��Ĵ���
	);
	end COMPONENT;
	
	
	COMPONENT mem
	port(
		mem_regdst:  in std_logic_vector(3 downto 0);
		mem_regwrite:in std_logic; --�Ƿ���Ҫд��Ĵ���
		mem_wboraddr:in std_logic_vector(15 downto 0); --ALU1����Ľ��
		mem_memwrite:in std_logic; --�Ƿ�SW
		mem_memwritedata:in std_logic_vector(15 downto 0); --д���ڴ������
		mem_memtoreg:in std_logic; --д�ص�����������ALU��������Ƿô�õ�������
		mem_inst:in std_logic_vector(15 downto 0); --IF�ζ�����ָ��
		clk:in std_logic;
		clk25:in std_logic;
		rst:in std_logic;
		ram1_we:out std_logic;
		ram1_oe:out std_logic;
		ram1_en:out std_logic;
		data_ready : in  STD_LOGIC;
		tbre: in  STD_LOGIC;
		tsre: in  STD_LOGIC;
		rdn : out  STD_LOGIC;
		wrn : out  STD_LOGIC;
		ram1_addr:out std_logic_vector(17 downto 0);  --ram1�ĵ�ַ
		wb_data:out std_logic_vector(15 downto 0);  --д�ؼĴ��������ݣ���mem_wboraddr��ram1_data��mem_inst��ѡ��
		wb_regwrite:out std_logic; --�Ƿ���Ҫд��Ĵ���
		wb_regdst:out std_logic_vector(3 downto 0);  --д���ĸ��Ĵ���
		ram1_data:inout std_logic_vector(15 downto 0) --ram1������
	);
	end COMPONENT;
	
	COMPONENT wb
	port(
		wb_data:in std_logic_vector(15 downto 0); --д�ؼĴ���������
		wb_regwrite:in std_logic; --�Ƿ���Ҫд��Ĵ���
		wb_regdst:in std_logic_vector(3 downto 0); --д���ĸ��Ĵ���
		rst:in std_logic;
		reg_writedata:out std_logic_vector(15 downto 0); --д�ؼĴ���������
		reg_we:out std_logic; --�Ƿ���Ҫд��Ĵ���
		reg_writeno:out std_logic_vector(3 downto 0) --д���ĸ��Ĵ���
	);
	end COMPONENT;
	
	signal alu1_operand1: std_logic_vector(15 downto 0);
	signal alu1_operand2: std_logic_vector(15 downto 0);
	signal alu1_opkind: std_logic_vector(15 downto 0);
	signal regwrite: std_logic;
	signal regdst: std_logic_vector(3 downto 0);
	signal memwrite: std_logic;
	signal memwritedata: std_logic_vector(15 downto 0);
	signal memtoreg: std_logic;
	signal wb_data : std_logic_vector(15 downto 0);
	signal wb_regwrite :std_logic;
	signal wb_regdst : std_logic_vector(3 downto 0);
	signal isLW: std_logic;
		
	mem_regdst:std_logic_vector(3 downto 0);
	mem_regwrite:std_logic; --�Ƿ���Ҫд��Ĵ���
	mem_wboraddr:std_logic_vector(15 downto 0); --ALU1����Ľ��
	mem_memwrite: std_logic; --�Ƿ�SW
	mem_memwritedata: std_logic_vector(15 downto 0); --д���ڴ������
	mem_memtoreg: std_logic; --д�ص�����������ALU��������Ƿô�õ�������
	mem_inst: std_logic_vector(15 downto 0); --IF�ζ�����ָ��
	clk: std_logic;
	clk25: std_logic;
	ram1_we: std_logic;
	ram1_oe: std_logic;
	ram1_en: std_logic;
	data_ready :  STD_LOGIC;
   tbre:  STD_LOGIC;
   tsre:  STD_LOGIC;
	rdn :  STD_LOGIC;
   wrn :  STD_LOGIC;
	ram1_addr: std_logic_vector(17 downto 0);  --ram1�ĵ�ַ
	wb_data: std_logic_vector(15 downto 0);  --д�ؼĴ��������ݣ���mem_wboraddr��ram1_data��mem_inst��ѡ��
	wb_regwrite: std_logic; --�Ƿ���Ҫд��Ĵ���
	wb_regdst: std_logic_vector(3 downto 0);  --д���ĸ��Ĵ���
	ram1_data: std_logic_vector(15 downto 0) --ram1������

	wb_data: std_logic_vector(15 downto 0); --д�ؼĴ���������
	wb_regwrite: std_logic; --�Ƿ���Ҫд��Ĵ���
	wb_regdst: std_logic_vector(3 downto 0); --д���ĸ��Ĵ���
	reg_writedata: std_logic_vector(15 downto 0); --д�ؼĴ���������
	reg_we: std_logic; --�Ƿ���Ҫд��Ĵ���
begin


	u1:EXE port map(
		rst => rst,
		exe_alu1_operand1 => alu1_operand1,
		exe_alu1_operand2 => alu1_operand2,
		exe_alu1_opkind => alu1_opkind,
		exe_regwrite => regwrite,
		exe_regdst => regdst,
		exe_memwrite => memwrite,
		exe_memwritedata => memwritedata,
		exe_memtoreg => memtoreg,
		mem_wb_data => wb_data,
		mem_wb_regwrite : in std_logic;
		mem_wb_regdst : in std_logic_vector(3 downto 0);
		exe_isLW: in std_logic;
		
		mem_regwrite : out std_logic;
		mem_regdst : out std_logic_vector(3 downto 0);
		mem_wboraddr : out std_logic_vector(15 downto 0);
		mem_memwrite : out std_logic;
		mem_memwritedata : out std_logic_vector(15 downto 0);
		mem_memtoreg : out std_logic;
		if_wboraddr : out std_logic_vector(15 downto 0);
		if_flush_from_exe : out std_logic;
		
		id_regwrite_from_exe: out std_logic;
		id_regdst_from_exe: out std_logic_vector(3 downto 0);
		id_isLW_from_exe: out std_logic
	);
	
	u2:mem port map(
		mem_regdst => mem_regdst;
		mem_regwrite => mem_regwrite, --�Ƿ���Ҫд��Ĵ���
		mem_wboraddr => mem_wboraddr, --ALU1����Ľ��
		mem_memwrite => mem_memwrite, --�Ƿ�SW
		mem_memwritedata => mem_memwritedata, --д���ڴ������
		mem_memtoreg => mem_memtoreg, --д�ص�����������ALU��������Ƿô�õ�������
		mem_inst => mem_memtoreg; --IF�ζ���
		clk => clk,
		clk25 => clk25,
		rst => rst,
		ram1_we => ram1_we ,
		ram1_oe => ram1_oe ,
		ram1_en => ram1_en;
		data_ready => data_ready,
		tbre => tbre,
		tsre => tsre,
		rdn => rdn,
		wrn => wrn;
		ram1_addr => ram1_addr,--ram1�ĵ�ַ
		wb_data=>  wb_data,
		wb_regwrite =>wb_regwrite,
		wb_regdst=>wb_regdst,
		ram1_data=>ram1_data
	);
end Behavioral;

