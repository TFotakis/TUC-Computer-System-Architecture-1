library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity IFID_Register is
    Port ( 	input : in  STD_LOGIC_VECTOR (31 downto 0);
						output : out  STD_LOGIC_VECTOR (31 downto 0);
						clk : in  STD_LOGIC;
						reset : in STD_LOGIC);
end IFID_Register;
architecture Behavioral of IFID_Register is
begin
process(clk, reset)
begin
	if(reset='1') then output<=std_logic_vector(to_unsigned(0,32));
	elsif(rising_edge(clk)) then output<=input;
	end if;
end process;
end Behavioral;