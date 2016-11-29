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
		clk:					in std_logic;
		rst:					in std_logic;
		
		memram1_en:				out std_logic;
		memram1_oe:				out std_logic;
		memram1_we:				out std_logic;
		memram1_addr:			out std_logic_vector(17 downto 0);
		ram1mem_data:			inout std_logic_vector(15 downto 0);
		
		ifram2_en:				out std_logic;
		ifram2_oe:				out std_logic;
		ifram2_we:				out std_logic;
		ifram2_addr : 				out  STD_LOGIC_VECTOR (17 downto 0);
		ram2if_data : 				inout  STD_LOGIC_VECTOR (15 downto 0);
		chuanmem_data_ready : 			in  STD_LOGIC;
      chuanmem_tbre : 					in  STD_LOGIC;
      chuanmem_tsre : 					in  STD_LOGIC;
		memchuan_rdn : 					out  STD_LOGIC;
      memchuan_wrn : 					out  STD_LOGIC
		
--		flashData : 			inout  std_logic_vector(15 downto 0);
--		flashAddr : 			out std_logic_vector(22 downto 0);
--		flashByte:				out std_logic;
--		flashVpen:				out std_logic;
--		flashCE:				out std_logic;
--		flashOE:				out std_logic;
--		flashWE:				out std_logic;
--		flashRP:				out std_logic;
		
		
--		key_datain:				in std_logic;
--		key_clkin:				in std_logic;
		
--		light:					out std_logic_vector(15 downto 0);
--		SW:						in std_logic_vector(15 downto 0);
--		seg_h:					out std_logic_vector(6 downto 0);
--		seg_l:					out std_logic_vector(6 downto 0)
	);
end CPU;

architecture Behavioral of CPU is

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
			  clk25 : in STD_LOGIC;	--clk25是一个状态，clk25 = '0' 表示流水线周期的上升沿
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

	COMPONENT IDtoEXE
		port(
			clk : in std_logic;
			clk25: in std_logic;
			rst : in std_logic;
			in_exe_alu1_operand1: in std_logic_vector(15 downto 0);
			in_exe_alu1_operand2: in std_logic_vector(15 downto 0);
			in_exe_alu1_opkind: in std_logic_vector(3 downto 0);

			in_exe_regwrite: in std_logic;
			in_exe_regdst: in std_logic_vector(3 downto 0);
			in_exe_memtoreg:in std_logic;
			
			in_exe_memwrite: in std_logic;
			in_exe_memwritedata : in std_logic_vector(15 downto 0);
			
			out_exe_alu1_operand1: out std_logic_vector(15 downto 0); 
			out_exe_alu1_operand2: out std_logic_vector(15 downto 0);
			out_exe_alu1_opkind: out std_logic_vector(3 downto 0);
			
			out_exe_regwrite: out std_logic;
			out_exe_regdst: out std_logic_vector(3 downto 0);
			out_exe_memtoreg: out std_logic;
			
			out_exe_memwrite: out std_logic;
			out_exe_memwritedata: out std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
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
	end COMPONENT;
	
	COMPONENT exemem
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
	end COMPONENT;
		
	COMPONENT mem
	port(
		mem_regdst:  in std_logic_vector(3 downto 0);
		mem_regwrite:in std_logic; --是否需要写入寄存器
		mem_wboraddr:in std_logic_vector(15 downto 0); --ALU1算出的结果
		mem_memwrite:in std_logic; --是否SW
		mem_memwritedata:in std_logic_vector(15 downto 0); --写入内存的内容
		mem_memtoreg:in std_logic; --写回的内容是来自ALU的输出还是访存得到的数据
		mem_inst:in std_logic_vector(15 downto 0); --IF段读到的指令
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
		ram1_addr:out std_logic_vector(17 downto 0);  --ram1的地址
		ram1_data:inout std_logic_vector(15 downto 0); --ram1的数据
		wb_data:out std_logic_vector(15 downto 0);  --写回寄存器的数据（从mem_wboraddr，ram1_data和mem_inst中选择）
		wb_regwrite:out std_logic; --是否需要写入寄存器
		wb_regdst:out std_logic_vector(3 downto 0);  --写入哪个寄存器
		id_regwrite_from_mem: out STD_LOGIC;
		id_regwritedata_from_mem: out STD_LOGIC_VECTOR (15 downto 0);
		id_regdst_from_mem: out STD_LOGIC_VECTOR (3 downto 0)
	);
	end COMPONENT;
	
	COMPONENT memwb
	port(
		clk: in std_logic;
		clk25: in std_logic;
		rst: in std_logic;
		in_wb_data:in std_logic_vector(15 downto 0); --写回寄存器的数据
		in_wb_regwrite:in std_logic; --是否需要写入寄存器
		in_wb_regdst:in std_logic_vector(3 downto 0); --写入哪个寄存器
		out_wb_data:out std_logic_vector(15 downto 0); --写回寄存器的数据
		out_wb_regwrite:out std_logic; --是否需要写入寄存器
		out_wb_regdst:out std_logic_vector(3 downto 0) --写入哪个寄存器
	);
	end COMPONENT;
	
	
	COMPONENT wb
	port(
		wb_data:in std_logic_vector(15 downto 0); --写回寄存器的数据
		wb_regwrite:in std_logic; --是否需要写入寄存器
		wb_regdst:in std_logic_vector(3 downto 0); --写入哪个寄存器
		rst:in std_logic;
		reg_writedata:out std_logic_vector(15 downto 0); --写回寄存器的数据
		reg_we:out std_logic; --是否需要写入寄存器
		reg_writeno:out std_logic_vector(3 downto 0) --写入哪个寄存器
	);
	end COMPONENT;
	
	signal clk25: STD_LOGIC := '0';
	
	--IF
	signal idif_branch : STD_LOGIC_VECTOR (15 downto 0);
	signal idif_jump: STD_LOGIC_VECTOR (15 downto 0);
   signal idif_branchjump_ctr : STD_LOGIC_VECTOR(1 downto 0);
   signal idif_flush_from_id : STD_LOGIC;
   signal exeif_flush_from_exe : STD_LOGIC;
   signal exeif_wboraddr : STD_LOGIC_VECTOR (15 downto 0);
   signal exeif_memwrite : STD_LOGIC;
	signal exeif_memwritedata : STD_LOGIC_VECTOR (15 downto 0);
   signal ififid_inst : STD_LOGIC_VECTOR (15 downto 0);
   signal ififid_pc : STD_LOGIC_VECTOR (15 downto 0);
   signal ifmem_inst : STD_LOGIC_VECTOR (15 downto 0);
	
	--ID
	signal ifidid_inst : STD_LOGIC_VECTOR (15 downto 0);
   signal ifidid_pc : STD_LOGIC_VECTOR (15 downto 0);
   signal regid_readdata1 : STD_LOGIC_VECTOR (15 downto 0);
   signal regid_readdata2 : STD_LOGIC_VECTOR (15 downto 0);
   signal regid_IH : STD_LOGIC_VECTOR (15 downto 0);
   signal regid_SP : STD_LOGIC_VECTOR (15 downto 0);
   signal regid_T : STD_LOGIC_VECTOR (15 downto 0);
   signal regid_RA : STD_LOGIC_VECTOR (15 downto 0);
	
   signal idreg_readno1 : STD_LOGIC_VECTOR (3 downto 0);
   signal idreg_readno2 : STD_LOGIC_VECTOR (3 downto 0);
   signal ididexe_alu1_operand1 : STD_LOGIC_VECTOR (15 downto 0);
   signal ididexe_alu1_operand2 : STD_LOGIC_VECTOR (15 downto 0);
   signal ididexe_alu1_opkind : STD_LOGIC_VECTOR (3 downto 0);
   signal ididexe_regwrite : STD_LOGIC;
   signal ididexe_regdst : STD_LOGIC_VECTOR (3 downto 0);
   signal ididexe_memtoreg : STD_LOGIC;
	signal ididexe_memwrite : STD_LOGIC;
   signal ididexe_memwritedata : STD_LOGIC_VECTOR (15 downto 0);
   signal idif_id_flush : STD_LOGIC;
			  
	signal exeid_regwrite_from_exe : STD_LOGIC;
   signal exeid_regwritedata_from_exe : STD_LOGIC_VECTOR (15 downto 0);
   signal exeid_regdst_from_exe : STD_LOGIC_VECTOR (3 downto 0);
   signal exeid_isLW_from_exe : STD_LOGIC;
   signal memid_regwrite_from_mem : STD_LOGIC;
   signal memid_regwritedata_from_mem : STD_LOGIC_VECTOR (15 downto 0);
   signal memid_regdst_from_mem : STD_LOGIC_VECTOR (3 downto 0);
	
	--EXE
	signal idexeexe_alu1_operand1: std_logic_vector(15 downto 0);
	signal idexeexe_alu1_operand2: std_logic_vector(15 downto 0);
	signal idexeexe_alu1_opkind: std_logic_vector(3 downto 0);
	signal idexeexe_regwrite: std_logic;
	signal idexeexe_regdst: std_logic_vector(3 downto 0);
	signal idexeexe_memwrite: std_logic;
	signal idexeexe_memwritedata: std_logic_vector(15 downto 0);
	signal idexeexe_memtoreg: std_logic;
		
	signal exeexemem_regwrite : std_logic;
	signal exeexemem_regdst : std_logic_vector(3 downto 0);
	signal exeexemem_wboraddr : std_logic_vector(15 downto 0);
	signal exeexemem_memwrite : std_logic;
	signal exeexemem_memwritedata : std_logic_vector(15 downto 0);
	signal exeexemem_memtoreg : std_logic;
	
	--MEM
	signal exememmem_regdst: std_logic_vector(3 downto 0);
	signal exememmem_regwrite: std_logic; --是否需要写入寄存器
	signal exememmem_wboraddr: std_logic_vector(15 downto 0); --ALU1算出的结果
	signal exememmem_memwrite: std_logic; --是否SW
	signal exememmem_memwritedata: std_logic_vector(15 downto 0); --写入内存的内容
	signal exememmem_memtoreg: std_logic; --写回的内容是来自ALU的输出还是访存得到的数据
	signal exememmem_inst: std_logic_vector(15 downto 0); --IF段读到的指令
	signal memmemwb_data: std_logic_vector(15 downto 0);  --写回寄存器的数据（从mem_wboraddr，ram1_data和mem_inst中选择）
	signal memmemwb_regwrite: std_logic; --是否需要写入寄存器
	signal memmemwb_regdst: std_logic_vector(3 downto 0);  --写入哪个寄存器

	--WB
	signal memwbwb_data: std_logic_vector(15 downto 0); --写回寄存器的数据
	signal memwbwb_regwrite: std_logic; --是否需要写入寄存器
	signal memwbwb_regdst: std_logic_vector(3 downto 0); --写入哪个寄存器
	signal wbreg_writedata: std_logic_vector(15 downto 0); --写回寄存器的数据
	signal wbreg_writeno: std_logic_vector(3 downto 0); --写入哪个寄存器
	signal wbreg_we: std_logic; --是否需要写入寄存器
	
begin
	cpu_if:InstructionFetch port map(
		if_branch => idif_branch,
	   if_jump => idif_jump,
      if_branchjump_ctr => idif_branchjump_ctr,
      if_flush_from_id => idif_flush_from_id,
      if_flush_from_exe => exeif_flush_from_exe,
      if_wboraddr => exeif_wboraddr,
      if_memwrite => exeif_memwrite,
		if_memwritedata => exeif_memwritedata,
      clk => clk,
		clk25 => clk25,
      rst => rst,
      id_inst => ififid_inst,
      id_pc => ififid_pc,
      ram2_we => ifram2_we,
      ram2_oe => ifram2_oe,
      ram2_en => ifram2_en,
      ram2_addr => ifram2_addr,
		ram2_data => ram2if_data,
      mem_inst => ifmem_inst
	);
	
	cpu_iftoid: IFtoID port map( 
		in_id_inst => ififid_inst,
      in_id_pc => ififid_pc,
      if_id_flush => idif_id_flush,
		clk => clk,
		clk25 => clk25,
		rst => rst,
      out_id_inst => ifidid_inst,
      out_id_pc => ifidid_pc
	);
	
	cpu_id: ID port map(
		id_inst => ifidid_inst,
      id_pc => ifidid_pc,
      id_readdata1 => regid_readdata1,
      id_readdata2 => regid_readdata2,
      id_IH => regid_IH,
      id_SP => regid_SP,
      id_T => regid_T,
      id_RA => regid_RA,
      rst => rst,
			  
      exe_alu1_operand1 => ididexe_alu1_operand1,
      exe_alu1_operand2 => ididexe_alu1_operand2,
      exe_alu1_opkind => ididexe_alu1_opkind,
      reg_readno1 => idreg_readno1,
      reg_readno2 => idreg_readno2,
      exe_regwrite => ididexe_regwrite,
      exe_regdst => ididexe_regdst,
      exe_memtoreg => ididexe_memtoreg,
      if_branchjump_ctr => idif_branchjump_ctr,
      if_branch => idif_branch,
      if_jump => idif_jump,
		exe_memwrite => ididexe_memwrite,
      exe_memwritedata => ididexe_memwritedata,
      if_flush_from_id => idif_flush_from_id,
      if_id_flush => idif_id_flush,
			  
		id_regwrite_from_exe => exeid_regwrite_from_exe,
      id_regwritedata_from_exe => exeid_regwritedata_from_exe,
      id_regdst_from_exe => exeid_regdst_from_exe,
      id_isLW_from_exe => exeid_isLW_from_exe,
      id_regwrite_from_mem => memid_regwrite_from_mem,
      id_regwritedata_from_mem => memid_regwritedata_from_mem,
      id_regdst_from_mem => memid_regdst_from_mem
	);

	cpu_regfile: RegFile port map(
		clk => clk,
		clk25 => clk25,
		rst => rst,
			
		reg_readno1 => idreg_readno1,
		reg_readno2 => idreg_readno2,
		
		reg_writeno => wbreg_writeno,
		reg_writedata => wbreg_writedata,
		reg_we => wbreg_we,
			
		id_readdata1 => regid_readdata1,
		id_readdata2 => regid_readdata2,
		id_T => regid_T,
		id_SP => regid_SP,
		id_IH => regid_IH,
		id_RA => regid_RA
	);
	
	cpu_idtoexe: IDtoEXE port map(
		clk => clk,
		clk25 => clk25,
		rst => rst,
		in_exe_alu1_operand1 => ididexe_alu1_operand1,
		in_exe_alu1_operand2 => ididexe_alu1_operand2,
		in_exe_alu1_opkind => ididexe_alu1_opkind,
					
		in_exe_regwrite => ididexe_regwrite,
		in_exe_regdst => ididexe_regdst,
		in_exe_memtoreg => ididexe_memtoreg,
		
		in_exe_memwrite => ididexe_memwrite,
		in_exe_memwritedata => ididexe_memwritedata,
			
		out_exe_alu1_operand1 => idexeexe_alu1_operand1,
		out_exe_alu1_operand2 => idexeexe_alu1_operand2,
		out_exe_alu1_opkind => idexeexe_alu1_opkind,
			
		out_exe_regwrite => idexeexe_regwrite,
		out_exe_regdst => idexeexe_regdst,
		out_exe_memtoreg => idexeexe_memtoreg,
			
		out_exe_memwrite => idexeexe_memwrite,
		out_exe_memwritedata => idexeexe_memwritedata
	);
	
	cpu_exe: EXE port map(
		rst => rst,
		exe_alu1_operand1 => idexeexe_alu1_operand1,
		exe_alu1_operand2 => idexeexe_alu1_operand2,
		exe_alu1_opkind => idexeexe_alu1_opkind,
		exe_regwrite => idexeexe_regwrite,
		exe_regdst => idexeexe_regdst,
		exe_memwrite => idexeexe_memwrite,
		exe_memwritedata => idexeexe_memwritedata,
		exe_memtoreg => idexeexe_memtoreg,
		
		mem_regwrite => exeexemem_regwrite,
		mem_regdst => exeexemem_regdst,
		mem_wboraddr => exeexemem_wboraddr,
		mem_memwrite => exeexemem_memwrite,
		mem_memwritedata => exeexemem_memwritedata,
		mem_memtoreg => exeexemem_memtoreg,
		if_wboraddr => exeif_wboraddr,
		if_flush_from_exe => exeif_flush_from_exe,
		
		id_regwrite_from_exe => exeid_regwrite_from_exe,
		id_regwritedata_from_exe => exeid_regwritedata_from_exe,
		id_regdst_from_exe => exeid_regdst_from_exe,
		id_isLW_from_exe => exeid_isLW_from_exe
	);
	
	cpu_exemem: exemem port map(
		clk => clk,
		clk25 => clk25,
		rst => rst,
		in_mem_regwrite => exeexemem_regwrite,  --是否需要写入寄存器
		in_mem_regdst => exeexemem_regdst,  --写入哪个寄存器
		in_mem_wboraddr => exeexemem_wboraddr, --ALU1计算的结果
		in_mem_memwrite => exeexemem_memwrite,  --是否SW
		in_mem_memwritedata => exeexemem_memwritedata,  --写入内存的内容
		in_mem_memtoreg => exeexemem_memtoreg,  --写回的内容是来自ALU的输出还是访存得到的数据
		out_mem_regwrite => exememmem_regwrite, --是否需要写入寄存器
		out_mem_regdst => exememmem_regdst, --写入哪个寄存器
		out_mem_wboraddr => exememmem_wboraddr, --ALU1计算的结果
		out_mem_memwrite => exememmem_memwrite,  --是否SW
		out_mem_memwritedata => exememmem_memwritedata,  --写入内存的内容
		out_mem_memtoreg => exememmem_memtoreg  --写回的内容是来自ALU的输出还是访存得到的数据
	);
	
	cpu_mem: mem port map(
		mem_regdst => exememmem_regdst,
		mem_regwrite => exememmem_regwrite, --是否需要写入寄存器
		mem_wboraddr => exememmem_wboraddr, --ALU1算出的结果
		mem_memwrite => exememmem_memwrite, --是否SW
		mem_memwritedata => exememmem_memwritedata, --写入内存的内容
		mem_memtoreg => exememmem_memtoreg, --写回的内容是来自ALU的输出还是访存得到的数据
		mem_inst => ifmem_inst, --IF段读到
		clk => clk,
		clk25 => clk25,
		rst => rst,
		ram1_we => memram1_we,
		ram1_oe => memram1_oe,
		ram1_en => memram1_en,
		ram1_addr => memram1_addr,--ram1的地址
		ram1_data => ram1mem_data,
		data_ready => chuanmem_data_ready,
		tbre => chuanmem_tbre,
		tsre => chuanmem_tsre,
		rdn => memchuan_rdn,
		wrn => memchuan_wrn,
		wb_data => memmemwb_data,
		wb_regwrite => memmemwb_regwrite,
		wb_regdst => memmemwb_regdst,		
		id_regwrite_from_mem => memid_regwrite_from_mem,
		id_regwritedata_from_mem => memid_regwritedata_from_mem,
		id_regdst_from_mem => memid_regdst_from_mem
	);
	
	cpu_memwb: memwb port map(
		clk => clk,
		clk25 => clk25,
		rst => rst,
		in_wb_data => memmemwb_data, --写回寄存器的数据
		in_wb_regwrite => memmemwb_regwrite, --是否需要写入寄存器
		in_wb_regdst => memmemwb_regdst, --写入哪个寄存器
		out_wb_data => memwbwb_data, --写回寄存器的数据
		out_wb_regwrite => memwbwb_regwrite, --是否需要写入寄存器
		out_wb_regdst => memwbwb_regdst --写入哪个寄存器
	);
	
	cpu_wb: wb port map(
		wb_data => memwbwb_data, --写回寄存器的数据
		wb_regwrite => memwbwb_regwrite, --是否需要写入寄存器
		wb_regdst => memwbwb_regdst, --写入哪个寄存器
		rst => rst,
		reg_writedata => wbreg_writedata, --写回寄存器的数据
		reg_we => wbreg_we, --是否需要写入寄存器
		reg_writeno => wbreg_writeno --写入哪个寄存器
	);
	
	process (clk)
	begin
		if falling_edge(clk) then
			clk25 <= not clk25;
		end if;
	end process;
end Behavioral;

