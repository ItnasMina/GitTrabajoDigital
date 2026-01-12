library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Bloque3 is
end entity;

architecture Behavioral of TB_Bloque3 is

    -- Component Declaration for the Unit Under Test (UUT)
    component Bloque3
        port (
            clk           : in  std_logic;
            reset         : in  std_logic;
            continue      : in  std_logic;
            confirm       : in  std_logic;
            switches      : in  std_logic_vector (3 downto 0);
            player_number : in  std_logic_vector (3 downto 0); -- "0010"(2), "0011"(3), "0100"(4)
            freqdiv_end   : in  std_logic;                     -- Pulso de fin de 5s
            round         : in  unsigned (7 downto 0); -- Ronda actual
            rng           : in  std_logic_vector (5 downto 0);
            
            freqdiv_reset : out std_logic;
            segments7     : out std_logic_vector (19 downto 0); -- 4 dígitos x 5 bits
            leds          : out std_logic_vector (3 downto 0);  -- Barra de LEDs
            ap1           : out std_logic_vector (3 downto 0);  -- Apuesta al registro J1
            ap2           : out std_logic_vector (3 downto 0);  -- Apuesta al registro J2
            ap3           : out std_logic_vector (3 downto 0);  -- Apuesta al registro J3
            ap4           : out std_logic_vector (3 downto 0);  -- Apuesta al registro J4

            end_inserting : out std_logic                       -- Fin de fase
        );
    end component;

    constant clk_period : time := 10 ns;

    -- Signals to connect to UUT
    signal clk_tb           : std_logic := '0';
    signal reset_tb         : std_logic := '0';
    signal continue_tb      : std_logic := '0';
    signal confirm_tb       : std_logic := '0';
    signal switches_tb      : std_logic_vector (3 downto 0);
    signal player_number_tb : std_logic_vector (3 downto 0);
    signal freqdiv_end_tb   : std_logic := '0';
    signal round_tb         : unsigned (7 downto 0);
    signal rng_tb           : std_logic_vector (5 downto 0);
    
    signal freqdiv_reset_tb : std_logic;
    signal segments7_tb     : std_logic_vector (19 downto 0);
    signal leds_tb          : std_logic_vector (3 downto 0);
    signal ap1_tb           : std_logic_vector (3 downto 0);
    signal ap2_tb           : std_logic_vector (3 downto 0);
    signal ap3_tb           : std_logic_vector (3 downto 0);
    signal ap4_tb           : std_logic_vector (3 downto 0);

    signal end_inserting_tb : std_logic;



begin

clk_process :process
begin
    clk_tb <= '1';
    wait for clk_period/2;
    clk_tb <= '0';
    wait for clk_period/2;
end process;


uut: Bloque3
    port map (
        clk           => clk_tb,
        reset         => reset_tb,
        continue      => continue_tb,
        confirm       => confirm_tb,
        switches      => switches_tb,
        player_number => player_number_tb,
        freqdiv_end   => freqdiv_end_tb,
        round         => round_tb,
        rng           => rng_tb,
        
        freqdiv_reset => freqdiv_reset_tb,
        segments7     => segments7_tb,
        leds          => leds_tb,
        ap1           => ap1_tb,
        ap2           => ap2_tb,
        ap3           => ap3_tb,
        ap4           => ap4_tb,

        end_inserting => end_inserting_tb
    );

tb : process
begin
    -- Reset the UUT
    reset_tb <= '1';
    wait for clk_period * 2.5;
    reset_tb <= '0';

                --------------------
                -- 2 PLAYERS TEST --
                --------------------

    player_number_tb <= "0010"; -- 2 players

    --############### Round 0 ###############--

    round_tb <= to_unsigned(0, 8);

    rng_tb <= "000101";         --RNG=5  [Bet of 1]  [R0:P1]

    wait for clk_period * 50;

    freqdiv_end_tb <= '1';      -- End of 5s
    wait for clk_period;
    freqdiv_end_tb <= '0';
    wait for clk_period * 10;

    --------------------------------------------

    switches_tb <= "0111";    -- [Bet of 7] [R0:P2]

    wait for clk_period*10;

    confirm_tb <= '1';          -- Press confirm
    wait for clk_period;
    confirm_tb <= '0';


    wait for clk_period * 50;

    freqdiv_end_tb <= '1';      -- End of 5s
    wait for clk_period;
    freqdiv_end_tb <= '0';
    wait for clk_period * 10;

    --------------------------------------------

    switches_tb <= "0011";    -- [Bet of 3]   [R0:P2]

    wait for clk_period*10;

    confirm_tb <= '1';          -- Press confirm
    wait for clk_period;
    confirm_tb <= '0';


    wait for clk_period * 50;

    freqdiv_end_tb <= '1';      -- End of 5s
    wait for clk_period;
    freqdiv_end_tb <= '0';
    wait for clk_period * 10;

    --------------------------------------------


    --############### Round 1 ###############--
    round_tb <= to_unsigned(1, 8);
    wait for clk_period * 2;

    -- Reset the UUT
    reset_tb <= '1';
    wait for clk_period * 2.5;
    reset_tb <= '0';
    wait for clk_period * 2;


    switches_tb <= "0100";    -- [Bet of 4]   [R1:P2]

    wait for clk_period*10;

    confirm_tb <= '1';          -- Press confirm
    wait for clk_period;
    confirm_tb <= '0';

    wait for clk_period * 50;

    freqdiv_end_tb <= '1';      -- End of 5s
    wait for clk_period;
    freqdiv_end_tb <= '0';

    --------------------------------------------

    rng_tb <= "000110";    -- RNG=6 [Bet of 6]   [R1:P1]
 
    wait for clk_period*50;

    freqdiv_end_tb <= '1';      -- End of 5s
    wait for clk_period;
    freqdiv_end_tb <= '0';
    wait for clk_period * 10;

    --------------------------------------------

    --############### Round 2 ###############--
    round_tb <= to_unsigned(2, 8);
    wait for clk_period * 2;

    -- Reset the UUT
    reset_tb <= '1';
    wait for clk_period;
    reset_tb <= '0';
    wait for clk_period * 2;


    rng_tb <= "010001";    -- RNG=17 [Bet of 4]   [R2:P1]


    wait for clk_period * 50;

    freqdiv_end_tb <= '1';      -- End of 5s
    wait for clk_period;
    freqdiv_end_tb <= '0';
    wait for clk_period * 100;

    --------------------------------------------

    switches_tb <= "0110";    -- [Bet of 6]   [R2:P2]

    wait for clk_period*10;

    confirm_tb <= '1';          -- Press confirm
    wait for clk_period;
    confirm_tb <= '0';
 
    wait for clk_period * 50;

    freqdiv_end_tb <= '1';      -- End of 5s
    wait for clk_period;
    freqdiv_end_tb <= '0';
    wait for clk_period * 10;

    --------------------------------------------

    -- Finish simulation
    wait;
end process;

end architecture;