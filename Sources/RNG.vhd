library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RNG is
    Port ( clk     : in  STD_LOGIC;
           reset   : in  STD_LOGIC; --Reset de la placa
           random_number : out STD_LOGIC_VECTOR (5 downto 0));
end RNG;


architecture Behavioral of RNG is
signal counter : integer range 0 to 51 := 0;            -- %52 en el m.c.m. de 4 y 13
begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            random_number <= (others => '0');
        elsif clk'event and clk = '1' then
            if counter = 51 then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
            random_number <= std_logic_vector(to_unsigned(counter, 6));
        end if;
    end process;
end Behavioral;