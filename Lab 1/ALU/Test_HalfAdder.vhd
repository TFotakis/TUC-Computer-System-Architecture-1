--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:33:09 02/09/2017
-- Design Name:   
-- Module Name:   E:/Workspace Xilinx/lab1/Test_Halfadder.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HalfAdder
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_Halfadder IS
END Test_Halfadder;
 
ARCHITECTURE behavior OF Test_Halfadder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HalfAdder
    PORT(
         inputA : IN  std_logic_vector(31 downto 0);
         inputB : IN  std_logic_vector(31 downto 0);
         out1 : OUT  std_logic_vector(31 downto 0);
         out2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inputA : std_logic_vector(31 downto 0) := (others => '0');
   signal inputB : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal out1 : std_logic_vector(31 downto 0);
   signal out2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HalfAdder PORT MAP (
          inputA => inputA,
          inputB => inputB,
          out1 => out1,
          out2 => out2
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
