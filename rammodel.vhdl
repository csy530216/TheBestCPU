library ieee;
use ieee.std_logic_1164.all;

entity RAM32 is
    port(
        clk         : in std_logic;
        reset       : in std_logic;
        r_w         : in std_logic;
        address     : in std_logic_vector(15 downto 0);
        data_in     : in std_logic_vector(31 downto 0);
        data_out    : out std_logic_vector(31 downto 0));
end RAM32;

architecture Behavioral of RAM32 is
    type store_t is array (0 to 31) of std_logic_vector(31 downto 0);
    signal ram_32: store_t := (others => X"00000000");
begin
    process(clk)
     begin
        if rising_edge(clk) then
            if (r_w = '1') then
                ram_32(to_integer(unsigned(address(5 downto 0)))) <= data_in;
            else
                data_out <= ram_32(to_integer(address(5 downto 0)));
            end if;
        end if;
    end process;

end Behavioral;