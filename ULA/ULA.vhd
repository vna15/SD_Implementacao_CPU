--
--		Projeto ULA
--

library IEEE;
use IEEE.std_logic_1164.all;

entity ULA is port
(
	B,C: in std_logic_vector(7 downto 0);									-- Entradas da ULA
	S_full: in std_logic_vector(2 downto 0);								-- Sinais para selecionar a operação
	Q: out std_logic_vector(7 downto 0);									-- Saída da ULA
	Carry_Out: out std_logic													-- Sinal Carry_Out
);
end ULA;

architecture hardware of ULA is
	signal Out_sum, Out_and, Out_or, Out_not, Out_xor: std_logic_vector(7 downto 0);		-- Sinais Auxiliares que armazenam as saídas de cada operação.
	component Mux_8X1
		port(
			Adder_Out, Sub_Out, And_Out, Or_Out, Not_Out, Xor_Out, Cmp_Out: in std_logic_vector(7 downto 0);
			s: in std_logic_vector(2 downto 0);
			Q: out std_logic_vector(7 downto 0)		
		);
	end component;
	component adder_8_bits
		port(
			X,Y: in  std_logic_vector(7 downto 0);
			ci: in std_logic;
			Q: out std_logic_vector(7 downto 0);
			cout: out std_logic
		);
	end component;
	component And_8_bits
		port(
			X,Y: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	component Or_8_bits
		port(
			X,Y: in std_logic_vector(7 downto 0); 
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	component Not_8_bits
		port(
			X: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	component Xor_8_bits
		port(
			X,Y: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0)
		);
	end component;
	begin
		x0: adder_8_bits PORT MAP(B, C, '0', Out_sum, Carry_Out);
		x1: And_8_bits PORT MAP(B, C, Out_and);
		x2: Or_8_bits PORT MAP(B, C, Out_or);
		x3: Xor_8_bits PORT MAP(B, C, Out_xor);
		x4: Not_8_bits PORT MAP(C, Out_not);
		x5: Mux_8X1 PORT MAP(Out_sum, "01010101", Out_and, Out_or, Out_not, Out_xor, "00001111", S_full, Q);				-- Existe sinais pré determinados para a simulação fluir.
end hardware;