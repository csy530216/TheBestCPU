----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:39:03 11/26/2016 
-- Design Name: 
-- Module Name:    IF - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionFetch is
    Port ( if_branch : in  STD_LOGIC_VECTOR (15 downto 0);
           if_branch_ctr : in  STD_LOGIC;
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
end InstructionFetch;

architecture Behavioral of InstructionFetch is
	signal pc: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
	signal next_pc: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
begin
	next_pc <= pc + 1             when if_branch_ctr = '0' else
				  pc + 1 + if_branch when if_branch_ctr = '1' else
				  "0000000000000000";

	id_pc <= pc;
	
	ram2_addr(15 downto 0) <= if_wboraddr when if_wboraddr(15) = '0' else		--MEM段在读指令
									  pc          when if_wboraddr(15) = '1' else
									  "0000000000000000";
	
	ram2_addr(17 downto 16) <= "00";
	ram2_en <= '0';
	
	process (clk)
	begin
		if rising_edge(clk) then
			if clk25 = '0' then
				if (if_flush_from_id or if_flush_from_exe) = '0' then
					pc <= next_pc;
				end if;
				
				if if_wboraddr(15) = '0' then --说明MEM段在读指令
					if if_memwrite = '0' then
						--准备读
						ram2_oe <= '0';
						ram2_we <= '1';
						ram2_data <= (others => 'Z');
					else
						--准备写
						ram2_oe <= '1';
						ram2_we <= '1';
						ram2_data <= if_memwritedata;
					end if;
				else
					--准备读指令
					ram2_oe <= '0';
					ram2_we <= '1';
					ram2_data <= (others => 'Z');
				end if;
			else
				if if_wboraddr(15) = '0' then
					if if_memwrite = '0' then
						--把读到的数据取出来
						mem_inst <= ram2_data;
					else
						--拉低写信号以写入
						ram2_we <= '0';
					end if;
					id_inst <= "0000100000000000"; --NOP
				else
					mem_inst <= (others => '0');  --这句话无所谓
					id_inst <= ram2_data;
				end if;
			end if;
		end if;
	end process;

end Behavioral;