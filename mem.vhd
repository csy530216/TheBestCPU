----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:27:34 11/26/2016 
-- Design Name: 
-- Module Name:    mem - Behavioral 
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

entity mem is
port(
	mem_regdst:  in std_logic_vector(3 downto 0);
	mem_regwrite:in std_logic; --�Ƿ���Ҫд��Ĵ���
	mem_wboraddr:in std_logic_vector(15 downto 0); --ALU1����Ľ��
	mem_memwrite:in std_logic; --�Ƿ�SW
	mem_memwritedata:in std_logic_vector(15 downto 0); --д���ڴ������
	mem_memtoreg:in std_logic; --д�ص�����������ALU��������Ƿô�õ�������
	mem_inst:in std_logic_vector(15 downto 0); --IF�ζ�����ָ��
	clk:in std_logic;
	rst:in std_logic;
	ram1_we:out std_logic;
	ram1_oe:out std_logic;
	ram1_en:out std_logic;
	data_ready : in  STD_LOGIC;
   tbre: in  STD_LOGIC;
   tsre: in  STD_LOGIC;
	rdn : out  STD_LOGIC;
   wrn : out  STD_LOGIC
	ram1_addr:out std_logic_vector(17 downto 0);  --ram1�ĵ�ַ
	wb_data:out std_logic_vector(15 downto 0);  --д�ؼĴ��������ݣ���mem_wboraddr��ram1_data��mem_inst��ѡ��
	wb_regwrite:out std_logic; --�Ƿ���Ҫд��Ĵ���
	wb_regdst:out std_logic_vector(3 downto 0);  --д���ĸ��Ĵ���
	ram1_data:inout std_logic_vector(15 downto 0); --ram1������
);
end mem;

architecture Behavioral of mem is
type status is (rm, tp, rp, wp, wm);
signal state:	status;
begin
	ram1addr(17 downto 16) <= "00";
	wb_regwrite <= '1';
	ram1_en <= '0';
	rdn <= '1';
	wrn <= '1';
	ram1_oe <= '1';
	ram1_we <= '1';
	process(clk, rst)
	begin
		if rst = '0' then
			wb_regwrite <= '1';
			ram1_en <= '0';
			rdn <= '1';
			wrn <= '1';
			ram1_oe <= '1';
			ram1_we <= '1';
		elsif rising_edge(clk) then
			if clk25 = '1' then
				wb_regwrite <= mem_regwrite;
				wb_regdst <= mem_regdst;				
				case state is
					when rp =>
						rdn <= '1';
						wb_data <= ram1_data;
					when rm =>
						ram1_oe <= '0';
						wb_data <= ram1_data;
					when tp =>
						wb_data <= ram1_data;
					when wp =>
						wrn <= '0';
					when wm =>
						ram1_we <= '0';
			else				
				if mem_regwrite = '0' then
					if addr = "1011111100000001" then					--test port
						ram1_data(0) <= (tbre and tsre);
						ram1_data(1) <= data_ready;
						ram1_data(15 downto 2) <= (others => '0');
						state <= tp;
					elsif addr = "1011111100000000" then				--read port
						ram1_data<= (others => 'Z');
						rdn <= '0';
						ram1_en <= '1';
						state <= rp;
					elsif addr > "0111111111111111" then				--read ram1
						ram1_en <= '0';
						ram1_addr(15 downto 0) <= mem_wboraddr;
						ram1_data <= (others => 'Z');
						state <= rm;
					end if;
					
				else						
					if addr = "1011111100000000" then				--write port
						ram1_en <= '1';
						ram1_data <= mem_memwritedata;
						state <= wp;
					elsif addr > "0001111111111111" then				--write ram1
						ram1_en <= '0';
						ram1_addr(15 downto 0) <= mem_wboraddr;
						ram1_data <= mem_memwritedata;
						state <= wm;
					end if;
				end if;					
			end if;
	end process;
	
end Behavioral;

