library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Bloque2 is
end entity;

architecture Behavioral of TB_Bloque2 is

    -- Component Declaration for the Unit Under Test (UUT)
    component Bloque2
        port (
            clk           : in  std_logic;
            reset         : in  std_logic;
            
            NUM_JUGADORES : in  std_logic_vector (3 downto 0);  -- "0010"(2), "0011"(3), "0100"(4)
            NUM_RONDA     : in  unsigned (7 downto 0);          -- Ronda actual
            ALEATORIO_IN  : in  std_logic_vector (5 downto 0);
            SWITCHES      : in  std_logic_vector (3 downto 0);
            BTN_CONFIRM   : in  std_logic;
            BTN_CONTINUAR : in  std_logic;

            freqdiv_end   : in  std_logic;                     

            freqdiv_reset : out std_logic;
            segments7     : out std_logic_vector (19 downto 0);
            PIEDRAS_P1           : out std_logic_vector (3 downto 0);
            PIEDRAS_P2           : out std_logic_vector (3 downto 0); 
            PIEDRAS_P3           : out std_logic_vector (3 downto 0); 
            PIEDRAS_P4           : out std_logic_vector (3 downto 0); 

            FIN_FASE : out std_logic
        );
    end component;


    constant clk_period : time := 10 ns;

    -- Signals to connect to UUT
    signal clk_tb           : std_logic;
    signal reset_tb         : std_logic;
    
    signal NUM_JUGADORES_tb : std_logic_vector (3 downto 0);  -- "0010"(2), "0011"(3), "0100"(4)
    signal NUM_RONDA_tb     : unsigned (7 downto 0);          -- Ronda actual
    signal ALEATORIO_IN_tb  : std_logic_vector (5 downto 0);
    signal SWITCHES_tb      : std_logic_vector (3 downto 0);
    signal BTN_CONFIRM_tb   : std_logic;
    signal BTN_CONTINUAR_tb : std_logic;

    signal freqdiv_end_tb   : std_logic;                     

    signal freqdiv_reset_tb : std_logic;
    signal segments7_tb     : std_logic_vector (19 downto 0);
    signal PIEDRAS_P1_tb           : std_logic_vector (3 downto 0);
    signal PIEDRAS_P2_tb           : std_logic_vector (3 downto 0); 
    signal PIEDRAS_P3_tb           : std_logic_vector (3 downto 0); 
    signal PIEDRAS_P4_tb           : std_logic_vector (3 downto 0);

    signal FIN_FASE_tb : std_logic;

begin

    clk_process :process
    begin
        clk_tb <= '1';
        wait for clk_period/2;
        clk_tb <= '0';
        wait for clk_period/2;
    end process;


    uut: Bloque2
        port map (
                clk          => clk_tb,         
                reset        => reset_tb,       
                
                NUM_JUGADORES => NUM_JUGADORES_tb,
                NUM_RONDA    => NUM_RONDA_tb,
                ALEATORIO_IN => ALEATORIO_IN_tb, 
                SWITCHES      => SWITCHES_tb,
                BTN_CONFIRM   => BTN_CONFIRM_tb,
                BTN_CONTINUAR => BTN_CONTINUAR_tb,

                freqdiv_end   => freqdiv_end_tb,                 

                freqdiv_reset => freqdiv_reset_tb,
                segments7     => segments7_tb,
                PIEDRAS_P1    => PIEDRAS_P1_tb,
                PIEDRAS_P2    => PIEDRAS_P2_tb,
                PIEDRAS_P3    => PIEDRAS_P3_tb,
                PIEDRAS_P4    => PIEDRAS_P4_tb,

                FIN_FASE    => FIN_FASE_tb
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

        NUM_JUGADORES_tb <= "0010"; -- 2 players

        --############### Round 0 ###############--

        NUM_RONDA_tb <= to_unsigned(0, 8);

        ALEATORIO_IN_tb <= "000101";    --RNG=5  [Bet of 1]  [R0:P1]

        wait for clk_period * 50;

        freqdiv_end_tb <= '1';          -- End of 5s
        wait for clk_period;
        freqdiv_end_tb <= '0';
        wait for clk_period * 10;

        --------------------------------------------

        SWITCHES_tb <= "0111";          -- 7 [Bet of 7] [R0:P2]

        wait for clk_period*10;

        BTN_CONFIRM_tb <= '1';          -- Press confirm
        wait for clk_period;
        BTN_CONFIRM_tb <= '0';


        wait for clk_period * 50;

        freqdiv_end_tb <= '1';          -- End of 5s
        wait for clk_period;
        freqdiv_end_tb <= '0';
        wait for clk_period * 10;

        --------------------------------------------

        SWITCHES_tb <= "0011";          -- [Bet of 3]   [R0:P2]

        wait for clk_period*10;

        BTN_CONFIRM_tb <= '1';          -- Press confirm
        wait for clk_period;
        BTN_CONFIRM_tb <= '0';


        wait for clk_period * 50;

        freqdiv_end_tb <= '1';          -- End of 5s
        wait for clk_period;
        freqdiv_end_tb <= '0';
        wait for clk_period * 10;

        --------------------------------------------


        --############### Round 1 ###############--
        NUM_RONDA_tb <= to_unsigned(1, 8);
        wait for clk_period * 2;

        -- Reset the UUT
        reset_tb <= '1';
        wait for clk_period * 2.5;
        reset_tb <= '0';

        --------------------------------------------

        ALEATORIO_IN_tb <= "000110";    -- RNG=6 [Bet of 2]   [R1:P1]
    
        wait for clk_period*50;

        freqdiv_end_tb <= '1';      -- End of 5s
        wait for clk_period;
        freqdiv_end_tb <= '0';
        wait for clk_period * 10;
        --------------------------------------------

        SWITCHES_tb <= "0000";    -- [Bet of 0]   [R1:P2]

        wait for clk_period*10;

        BTN_CONFIRM_tb <= '1';     -- Press confirm
        wait for clk_period;
        BTN_CONFIRM_tb <= '0';

        wait for clk_period * 50;

        freqdiv_end_tb <= '1';      -- End of 5s
        wait for clk_period;
        freqdiv_end_tb <= '0';

        --------------------------------------------

        --############### Round 2 ###############--
        NUM_RONDA_tb <= to_unsigned(2, 8);
        wait for clk_period * 2;

        -- Reset the UUT
        reset_tb <= '1';
        wait for clk_period;
        ALEATORIO_IN_tb <= "010001";    -- RNG=17 [Bet of 1]   [R2:P1]
        reset_tb <= '0';



        ALEATORIO_IN_tb <= "010001";    -- RNG=17 [Bet of 1]   [R2:P1]


        wait for clk_period * 50;

        freqdiv_end_tb <= '1';      -- End of 5s
        wait for clk_period;
        freqdiv_end_tb <= '0';
        wait for clk_period * 100;

        --------------------------------------------

        SWITCHES_tb <= "0010";    -- [Bet of 2]   [R2:P2]

        wait for clk_period*10;

        BTN_CONFIRM_tb <= '1';     -- Press confirm
        wait for clk_period;
        BTN_CONFIRM_tb <= '0';
    
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