--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:24:17 11/24/2013
-- Design Name:   
-- Module Name:   D:/Src/Computer/computer_work/CPU/TestOfCpu.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CPU_TB IS
END CPU_TB;
 
ARCHITECTURE behavior OF CPU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
		clk       :             in std_logic;
		rst:					in std_logic;
        	memram1_en:				out std_logic;
		memram1_oe:				out std_logic;
		memram1_we:				out std_logic;
		memram1_addr:			out std_logic_vector(17 downto 0);
		ram1mem_data:			inout std_logic_vector(15 downto 0);
		
		ifram2_en:				out std_logic;
		ifram2_oe:				out std_logic;
		ifram2_we:				out std_logic;
		ifram2_addr : 			out  STD_LOGIC_VECTOR (17 downto 0);
		ram2if_data : 			inout  STD_LOGIC_VECTOR (15 downto 0);
		chuanmem_data_ready : 	in  STD_LOGIC;
        chuanmem_tbre : 		in  STD_LOGIC;
        chuanmem_tsre : 		in  STD_LOGIC;
		memchuan_rdn : 			out  STD_LOGIC;
        memchuan_wrn : 			out  STD_LOGIC;
		led :                   out STD_LOGIC_VECTOR(15 downto 0);
		num :					out STD_LOGIC_VECTOR(13 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal chuanmem_data_ready : std_logic := '0';
   signal chuanmem_tbre : std_logic := '0';
   signal chuanmem_tsre : std_logic := '0';

	--BiDirs
   signal ram1mem_data : std_logic_vector(15 downto 0);
   signal ram2if_data : std_logic_vector(15 downto 0);

 	--Outputs
   signal memram1_addr : std_logic_vector(17 downto 0);
   signal memram1_en : std_logic;
   signal memram1_we : std_logic;
   signal memram1_oe : std_logic;
   signal ifram2_addr : std_logic_vector(17 downto 0);
   signal ifram2_en : std_logic;
   signal ifram2_we : std_logic;
   signal ifram2_oe : std_logic;
   signal memchuan_rdn : std_logic;
   signal memchuan_wrn : std_logic;
   signal led : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          clk => clk,
          rst => rst,
          memram1_addr => memram1_addr,
          memram1_en => memram1_en,
          memram1_we => memram1_we,
          memram1_oe => memram1_oe,
          ram1mem_data => ram1mem_data,
          ifram2_addr => ifram2_addr,
          ifram2_en => ifram2_en,
          ifram2_we => ifram2_we,
          ifram2_oe => ifram2_oe,
          ram2if_data => ram2if_data,
          chuanmem_data_ready => chuanmem_data_ready,
          memchuan_rdn => memchuan_rdn,
          chuanmem_tbre => chuanmem_tbre,
          chuanmem_tsre => chuanmem_tsre,
          memchuan_wrn => memchuan_wrn,
          led => led
        );

   -- Clock process definitions
   CLK_process :process
   begin
		clk <= '0';
		wait for clk_period/4;
		clk <= '1';
		wait for clk_period/4;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
      -- insert stimulus here 
	  wait for clk_period/3;

	  -- SW到IM
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";	--NOP			0800
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111010111111";	--LI R6 0x00BF			6EBF
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0011011011000000";	--SLL R6 R6 0x0000			36C0
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0100111000000001";	--ADDIU R6 0x0001			4E01
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1001111000000000";	--LW R6 R0 0x0000			9E00
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111000000010";	--LI R6 0x0002			6802
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110100011001100";	--AND R0 R6			E8CC
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0010000000011111";	--BEQZ R0 0x001F			201F
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";	--NOP			0800
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100101000000";	--LI R1 40			6940
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0011000100100000";	--SLL R1 R1 0000	3120
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110101010000000";	--LI R2 80
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101100101000000";	--SW R1 R2 0000
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110101100000001";	--LI R3 01
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110101100000010";	--LI R3 02
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110101100000011";	--LI R3 03
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110101100000100";	--LI R3 04
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
			  
	  --kernel
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000000000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000000000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0001000001000100";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1111000000000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100010111111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0011000000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0100100000010000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110010000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111010111111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0011011011000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0100111000010000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101111000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101111000000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101111000000010";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;		
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101111000000011";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101111000000100";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101111000000101";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110111101000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0100111100000011";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0001000001001010";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111010111111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111010111111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0011011011000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0100111000000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1001111000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111000000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110100011001100";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0010000011111000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110111100000000";	--JR R7
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
	  
	  
	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	  
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110111101000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110111101000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110111101000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110111101000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  -- test of JR
-------------------------------------------TESTW		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;

--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111010111111";  -- LI R6 BF 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;

--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0011011011000000";  -- SLL R6 R6 0x0000 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0100111000000001";	--ADDIU R6 0x0001 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "1001111000000000";	--LW R6 R0 0x0000 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111000000001";	--LI R6 0x0001 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110100011001100";	--AND R0 R6 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0010000011111000";	--BEQZ R0 TESTW
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;

-------------------------------------------访存到IM内		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000001";  -- LI R0 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000010";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
--		ram1mem_data <= (others=>'0');
		--ram2if_data <= "1001100101000001";  -- LW from IM  OK
		ram2if_data <= "1101100100000001";  -- SW to  
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100100000011";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100100000100";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100100000101";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100100000111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;	
		
		
-------------------------------------------条件跳转  OK
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000001";  -- LI R0 
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000010";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0010000000001111"; --BEQZ R0 1111
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		wait for clk_period;
		
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000100";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000101";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		
		
-------------------------------------------写后读		OK


		ram1mem_data <= (others=>'0');
		ram2if_data <= "1001100100000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110000000101001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110000000101001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;		
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110000000101001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
-------------------------------------------写后读		
		
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110000101000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110001000100001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		
		
		
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1001100000100010";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1001100001000011";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110000101000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110001000100001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110000101000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110001000100001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110000101000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1110001000100001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
			   
			   
	  
	  
	  
	  --kernel
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000000000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000000000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0001000001000100";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100000000111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1111000000000001";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110100010111111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		
		
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0000100000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0110111010111111";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0011011011000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "0100111000010000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;
		
		ram1mem_data <= (others=>'0');
		ram2if_data <= "1101111000000000";
		chuanmem_data_ready <= '1';
		chuanmem_tbre <= '1';
		chuanmem_tsre <= '1';
		wait for clk_period;



		
      wait;
   end process;

END;
