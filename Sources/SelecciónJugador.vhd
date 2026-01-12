library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SeleccionJugadores is
  port(
    clk            : in  std_logic;
    reset          : in  std_logic;  -- 1 = apagado (estado inicial), 0 = funcionando
    continue       : in  std_logic;
    switches       : in  std_logic_vector(3 downto 0);
    freq_div_fin   : in  std_logic;
    freq_div_start : out std_logic;  -- Va al reset del FreqDiv: 1=reset(parado), 0=contando
    Fin            : out std_logic;
    seven_segments : out std_logic_vector(19 downto 0);
    Num            : out std_logic_vector(3 downto 0)
  );
end SeleccionJugadores;

architecture Behavioral of SeleccionJugadores is

  signal aux1       : std_logic_vector(14 downto 0);
  signal aux2       : std_logic_vector(4 downto 0);

  signal started    : std_logic;  -- 1 mientras el divisor está contando (freq_div_start=0)
  signal cont_prev  : std_logic := '0';
  signal cont_pulse : std_logic := '0';

begin

  -- JUG fijo
  aux1 <= "100001000110010";

  -- último display: 2/3/4/_
  aux2 <= "00010" when switches = "0010" else
          "00011" when switches = "0011" else
          "00100" when switches = "0100" else
          "10100";

  seven_segments(19 downto 5) <= aux1;
  seven_segments(4 downto 0)  <= aux2;

  process(clk, reset)
  begin
    -- reset=1 => apagado
    if reset = '1' then
      Num <= "0000";
      Fin <= '0';
      started <= '0';
      cont_prev <= '0';
      cont_pulse <= '0';

    elsif (clk'event and clk = '1') then
      -- detector de flanco (pulsación)
      cont_pulse <= continue and (not cont_prev);
      cont_prev  <= continue;

      

      -- 1) Arranque: solo si NO estamos contando y hay pulsación + switches válido
      if started = '0' then
        if cont_pulse = '1' and
           (switches = "0010" or switches = "0011" or switches = "0100") then
          Num <= switches;
          started <= '1';
        end if;
      end if;

      -- 2) Fin: solo si estamos contando
      if started = '1' then
        -- Fin por tiempo (freq_div_fin) o por cancelación (continue)
        if freq_div_fin = '1' or cont_pulse = '1' then
          Fin <= '1';
          started <= '0';
        end if;
      end if;

    end if;
  end process;

  -- controlamos el comienzo del temporizador con la variable started
  with started select
    freq_div_start <= '0' when '1',
                      '1' when others;
end Behavioral;
