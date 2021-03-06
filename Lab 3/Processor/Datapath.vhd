library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity Datapath is
    Port (PC_Sel 					: in  	STD_LOGIC;
				PC_LdEn 				: in  	STD_LOGIC;
				RF_WrEn 				: in  	STD_LOGIC;
				RF_WrData_sel 	: in  	STD_LOGIC_VECTOR (1 downto 0);
				RF_B_sel 				: in  	STD_LOGIC;
				RF_AB_we			: in 	STD_LOGIC;
				ALU_Bin_sel 		: in  	STD_LOGIC;
				ALU_func 			: in  	STD_LOGIC_VECTOR (3 downto 0);
				ALU_Zero				: out	STD_LOGIC;
				MEM_WrEn 		: in  	STD_LOGIC;
				MEM_Control 		: in 	STD_LOGIC;
				Reset 					: in  	STD_LOGIC;
				Clk 						: in  	STD_LOGIC;
				RF_A 						: out  STD_LOGIC_VECTOR (31 downto 0);
				RF_B 						: out  STD_LOGIC_VECTOR (31 downto 0);
				Instr						: out 	STD_LOGIC_VECTOR (31 downto 0));
end Datapath;

architecture Structural of Datapath is
	component IFSTAGE
		 Port (PC_Immed 	: in  	STD_LOGIC_VECTOR (31 downto 0);
					PC_Sel 			: in  	STD_LOGIC;
					PC_LdEn 		: in  	STD_LOGIC;
					Reset 			: in  	STD_LOGIC;
					Clk 				: in  	STD_LOGIC;
					Instr 				: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component DECSTAGE
		 Port (Instr 						: in  	STD_LOGIC_VECTOR (31 downto 0);
					RF_WrEn 				: in  	STD_LOGIC;
					ALU_out 				: in  	STD_LOGIC_VECTOR (31 downto 0);
					MEM_out 			: in  	STD_LOGIC_VECTOR (31 downto 0);
					RF_WrData_sel	: in  	STD_LOGIC_VECTOR (1 downto 0);
					RF_B_sel 				: in  	STD_LOGIC;
					RF_AB_we			: in 	STD_LOGIC;
					Reset 					: in  	STD_LOGIC;
					Clk 						: in  	STD_LOGIC;
					Immed 				: out  STD_LOGIC_VECTOR (31 downto 0);
					RF_A 						: out  STD_LOGIC_VECTOR (31 downto 0);
					RF_B 						: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component ALUSTAGE
		 Port (RF_A 				: in  	STD_LOGIC_VECTOR (31 downto 0);
					RF_B 					: in  	STD_LOGIC_VECTOR (31 downto 0);
					Immed 			: in  	STD_LOGIC_VECTOR (31 downto 0);
					ALU_Bin_sel	: in  	STD_LOGIC;
					ALU_func 		: in  	STD_LOGIC_VECTOR (3 downto 0);
					ALU_out 			: out  STD_LOGIC_VECTOR (31 downto 0);
					ALU_Zero			: out	STD_LOGIC);
	end component;

	component MEMSTAGE
		 Port (clk 						: in  	STD_LOGIC;
					Mem_WrEn 		: in  	STD_LOGIC;
					ALU_MEM_Addr : in  	STD_LOGIC_VECTOR (31 downto 0);
					MEM_Datain		: in  STD_LOGIC_VECTOR (31 downto 0);
					MEM_Control 		: in 	STD_LOGIC;
					MEM_DataOut 	: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	signal InstrSig, ALU_out_sig, MEM_out_sig, ImmedSig, RF_A_sig, RF_B_sig: STD_LOGIC_VECTOR (31 downto 0);
begin
	IFSTAGE_0: IFSTAGE port map(	PC_Immed=>ImmedSig,
																	PC_Sel=>PC_Sel,
																	PC_LdEn=>PC_LdEn,
																	Reset=>Reset,
																	Clk=>Clk,
																	Instr=>InstrSig);

	DECSTAGE_0: DECSTAGE port map(Instr=>InstrSig,
																			RF_WrEn=>RF_WrEn,
																			ALU_out=>ALU_out_sig,
																			MEM_out=>MEM_out_sig,
																			RF_WrData_sel=>RF_WrData_sel,
																			RF_B_sel=>RF_B_sel,
																			RF_AB_we=>RF_AB_we,
																			Reset=>Reset,
																			Clk=>Clk,
																			Immed=>ImmedSig,
																			RF_A=>RF_A_sig,
																			RF_B=>RF_B_sig);

	ALUSTAGE_0: ALUSTAGE port map(	RF_A=>RF_A_sig,
																			RF_B=>RF_B_sig,
																			Immed=>ImmedSig,
																			ALU_Bin_sel=>ALU_Bin_sel,
																			ALU_func=>ALU_func,
																			ALU_out=>ALU_out_sig,
																			ALU_Zero=>ALU_Zero);

	MEMSTAGE_0: MEMSTAGE port map(	clk=>Clk,
																				Mem_WrEn=>MEM_WrEn,
																				ALU_MEM_Addr=>ALU_out_sig,
																				MEM_Datain=>RF_B_sig,
																				MEM_Control=>MEM_Control,
																				MEM_DataOut=>MEM_out_sig);
	
	RF_A<=RF_A_sig;
	RF_B<=RF_B_sig;
	Instr<= InstrSig;
end Structural;