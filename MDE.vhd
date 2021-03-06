entity mde is
    port ( ck ,opHLT, opLDR, opSTR, opMOV, opADD, opSUB, opAND, opOR, opNOT, opXOR, opCMP, opJMP, opJNC,opJC,opJNZ,opJZ,flagCarry,flagULA   : in bit ;
         SEL_addr_RF_escrita,SEL_RF_2_SUM,SEL_RF_leitura_1,en_RF_leitura_1,en_RF_leitura_2,en_RF_escrita,D_en,D_wr,flagCarry_ld,flagCarry_clr,flagULA_ld,flagULA_clr,PC_cnt,PC_ld,PC_clr,IR_ld,I_rd : out bit;
          SEL_RF   : out bit_vector (1 downto 0);
          SEL_ULA  : out bit_vector (2 downto 0)
);
end mde ;

architecture logica of mde is
    type st is (inicio, busca, decodificacao,stHLT, stLDR, stSTR,
		 stMOV, stADD, stSUB, stAND, stOR, stNOT, stXOR, stCMP,
		 stJMP, stJNC,stJC,stJNZ,stJZ, clearCarry, clearULA );
    signal estado : st ;
    
begin
  process (ck)
  begin

    if ( ck' event and ck = '1') then
      case estado is
        -----Saidas do estado "INICIO" 
        when inicio =>
		estado <= busca;
        -----Saidas do estado "busca"
        when busca =>
		estado <= decodificacao;
        -----Saidas do estado "decodificacao" 
        when decodificacao =>
          	if opHLT = '1' then estado <= stHLT;
          	elsif opLDR = '1' then estado <= stLDR;
          	elsif opSTR = '1' then estado <= stSTR;
          	elsif opMOV = '1' then estado <= stMOV;
          	elsif opADD = '1' then estado <= stADD;
          	elsif opSUB = '1' then estado <= stSUB;
          	elsif opAND = '1' then estado <= stAND;
		elsif opOR = '1' then estado <= stOR;
          	elsif opNOT = '1' then estado <= stNOT;
          	elsif opXOR = '1' then estado <= stXOR;
          	elsif opCMP = '1' then estado <= stCMP;
		elsif opJMP = '1' then estado <= stJMP;
          	elsif opJNC = '1' then estado <= stJNC;
		elsif opJC = '1' then estado <= stJC;
          	elsif opJNZ = '1' then estado <= stJNZ;
		elsif opJZ = '1' then estado <= stJZ;
         	end if;
        -----Saidas do estado "HLT" 
        when stHLT =>
		estado <= stHLT;
        -----Saidas do estado "LDR" 
        when stLDR =>
		estado <= busca;
        -----Saidas do estado "STR" 
        when stSTR =>
		estado <= busca;
        -----Saidas do estado "MOV" 
        when stMOV =>
		estado <= busca;
        -----Saidas do estado "ADD" 
        when stADD =>
		estado <= busca;
        -----Saidas do estado "SUB" 
        when stSUB =>
		estado <= busca;
        -----Saidas do estado "AND" 
        when stAND =>
		estado <= busca;
        -----Saidas do estado "OR" 
        when stOR =>
		estado <= busca;
        -----Saidas do estado "NOT" 
        when stNOT =>
		estado <= busca;
        -----Saidas do estado "XOR" 
        when stXOR =>
		estado <= busca;
        -----Saidas do estado "CMP" 
        when stCMP =>
		estado <= busca;
        -----Saidas do estado "JMP" 
        when stJMP =>
		estado <= busca;
        -----Saidas do estado "JNC" 
        when stJNC =>
		if flagCarry = '0' then estado <= clearCarry;
          	else	estado <= busca;
		end if;
        -----Saidas do estado "JC" 
        when stJC =>
		if flagCarry = '1' then estado <= clearCarry;
          	else	estado <= busca;
		end if;
        -----Saidas do estado "JNZ" 
        when stJNZ =>
		if flagULA= '1' then estado <= clearULA;
          	else	estado <= busca;
		end if;
        -----Saidas do estado "JZ" 
        when stJZ =>
		if flagULA= '0' then estado <= clearULA;
          	else	estado <= busca;
		end if;
        -----Saidas do estado "clearCarry" 
        when clearCarry =>
		estado <= stJMP;
        -----Saidas do estado "clearULA" 
        when clearULA =>
		estado <= stJMP;
	
	
      end case ;
    end if;
  end process ;
  
with estado select
	PC_clr <= '1' when inicio,
		  '0' when others;
with estado select
	PC_cnt <= '1' when busca,
		  '0' when others;
with estado select
	PC_ld <= '1' when stJMP,
		  '0' when others;
with estado select
	I_rd <= '1' when busca,
		  '0' when others;
with estado select
	IR_ld <= '1' when busca,
		 '0' when others;
with estado select
	SEL_addr_RF_escrita <= 	'1' when stADD,
				'1' when stSUB,
				'1' when stAND,
				'1' when stOR,
				'1' when stNOT,
				'1' when stXOR,
				'1' when stCMP,
				'1' when stLDR,
		 		'0' when others;
with estado select
	en_RF_escrita <= 	'1' when stADD,
				'1' when stSUB,
				'1' when stAND,
				'1' when stOR,
				'1' when stNOT,
				'1' when stXOR,
				'1' when stCMP,
				'1' when stLDR,
				'1' when stMOV,
		 		'0' when others;
with estado select
	SEL_RF_leitura_1 <= 	'1' when stSTR,
		 		'0' when others;
with estado select
	en_RF_leitura_1 <= 	'1' when stADD,
				'1' when stSUB,
				'1' when stAND,
				'1' when stOR,
				'1' when stXOR,
				'1' when stCMP,
				'1' when stSTR,
		 		'0' when others;

with estado select
	en_RF_leitura_2 <= 	'1' when stADD,
				'1' when stSUB,
				'1' when stAND,
				'1' when stOR,
				'1' when stNOT,
				'1' when stXOR,
				'1' when stCMP,
				'1' when stMOV,
		 		'0' when others;

with estado select
	flagCarry_ld <= 	'1' when stADD,
				'1' when stSUB,
		 		'0' when others;
with estado select
	flagULA_ld <= 		'1' when stADD,
				'1' when stSUB,
				'1' when stAND,
				'1' when stOR,
				'1' when stNOT,
				'1' when stXOR,
				'1' when stCMP,
		 		'0' when others;
with estado select
	flagCarry_clr <= 	'1' when clearCarry,
		 		'0' when others;
with estado select
	flagULA_clr <= 		'1' when clearULA,
		 		'0' when others;

with estado select
	SEL_ULA <= 		"000" when stADD,
				"000" when stSUB,
				"001" when stAND,
				"010" when stOR,
				"011" when stNOT,
				"100" when stXOR,
				"101" when stCMP,
		 		"000" when others;
with estado select
	SEL_RF_2_SUM <= 	'0' when stADD,
				'1' when stSUB,
		 		'0' when others;
with estado select
	SEL_RF <= 		"00" when stMOV,
				"01" when stLDR,
		 		"10" when others;

with estado select
	D_en <=		 	'1' when stLDR,
				'1' when stSTR,
		 		'0' when others;
with estado select
	D_wr <=		 	'1' when stSTR,
		 		'0' when others;


                     
end logica ;
