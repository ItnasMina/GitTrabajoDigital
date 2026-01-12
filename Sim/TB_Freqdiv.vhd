library IEEE;
use IEEE.std_logic_1164.all;


entity TB_Freqdiv is

end entity;

architecture Behavioral of TB_Freqdiv is

component Freqdiv is
    Port (clk    :  in  std_logic;
          reset  :  in  std_logic;
          en     :  in  std_logic;
          Output :  out std_logic);
end component;

constant clk_period : time := 20 ns;
signal clk_tb : std_logic;
signal reset_tb : std_logic := '0';
signal en_tb : std_logic := '1';
signal Output_tb : std_logic;

begin

UUT: Freqdiv
    port map (
        clk    => clk_tb,
        reset  => reset_tb,
        en     => en_tb,
        Output => Output_tb
    );

clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

end Behavioral;