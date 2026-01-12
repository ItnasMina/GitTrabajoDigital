library ieee;
use ieee.std_logic_1164.all;

entity TB_DecoderControler is
end entity;

architecture behavoural of TB_DecoderControler is

    signal Input0_tb  :   std_logic_vector(19 downto 0);
    signal Input1_tb  :   std_logic_vector(19 downto 0);
    signal Input2_tb  :   std_logic_vector(19 downto 0);
    signal Input3_tb  :   std_logic_vector(19 downto 0);
    signal Input4_tb  :   std_logic_vector(19 downto 0);
    signal Sel_tb     :   std_logic_vector( 2 downto 0);
    signal Output0_tb :   std_logic_vector( 6 downto 0);
    signal Output1_tb :   std_logic_vector( 6 downto 0);
    signal Output2_tb :   std_logic_vector( 6 downto 0);
    signal Output3_tb :   std_logic_vector( 6 downto 0);

    component DecoderControler is
        port(Input0  :   in  std_logic_vector(19 downto 0); --Seleccion nº de jugadores
             Input1  :   in  std_logic_vector(19 downto 0); --Seleccion nº de piedras
             Input2  :   in  std_logic_vector(19 downto 0); --Seleccion apuestas
             Input3  :   in  std_logic_vector(19 downto 0); --Resolución apuestas
             Input4  :   in  std_logic_vector(19 downto 0); --Fin de ronda
             Sel     :   in  std_logic_vector( 2 downto 0);
             Output0 :   out std_logic_vector( 6 downto 0);
             Output1 :   out std_logic_vector( 6 downto 0);
             Output2 :   out std_logic_vector( 6 downto 0);
             Output3 :   out std_logic_vector( 6 downto 0)
             );
    end component;
begin
    UUT: DecoderControler
        port map(
            Input0  => Input0_tb,
            Input1  => Input1_tb,
            Input2  => Input2_tb,
            Input3  => Input3_tb,
            Input4  => Input4_tb,
            Sel     => Sel_tb,
            Output0 => Output0_tb,
            Output1 => Output1_tb,
            Output2 => Output2_tb,
            Output3 => Output3_tb
        );

TB_process : process
begin
    Input0_tb <= "10000100011001010011"; -- "JUG_"
    Input1_tb <= "10100101010000011010"; -- "ch0 "
    Input2_tb <= "01010101100000111010"; -- "AP1 "
    Input3_tb <= "00010000110010000101"; -- "2345"
    Input4_tb <= "01111101111100000110"; -- "Fin6"

    -- Test case 1
    Sel_tb <= "000";
    wait for 1000 ns;

    -- Test case 2
    Sel_tb <= "001";
    wait for 1000 ns;

    -- Test case 3
    Sel_tb <= "010";
    wait for 1000 ns;

    -- Test case 4
    Sel_tb <= "011";
    wait for 1000 ns;

    -- Test case 5
    Sel_tb <= "100";
    wait for 1000 ns;

    wait;
end process;

end architecture;   