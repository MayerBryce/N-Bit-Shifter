entity lab3 is
	generic(N : integer := 8);
    port(inN       : in bit_vector(N-1 downto 0);
		 Mode      : in bit_vector(0 to 1);
		 Shift_in  : in bit;
		 Shift_out : out bit;
		 outN      : out bit_vector(N-1 downto 0));
end lab3;

architecture simple of lab3 is

begin
process(inN, Mode, Shift_in)
begin
    if (Mode = "00") then
        for i in 0 to N-1 loop
            OutN(i) <= InN(i);
        end loop;
        Shift_out <= Shift_in;
    end if;
    
    if (Mode = "01") then
        OutN(0) <= Shift_in;
        for i in 1 to N-1 loop
            OutN(i) <= InN(i-1);
        end loop;
        Shift_out <= InN(N-1);
    end if;
    
    if (Mode = "10") then
        for i in 0 to N-2 loop
            OutN(i) <= InN(i+1);
        end loop;
        outN(N-1) <= Shift_in;
        Shift_out <= InN(0);
    end if;
    
    if (Mode = "11") then
        for i in 0 to N-1 loop
            outN(i) <= '0';
        end loop;
        Shift_out <= '0';
    end if;
end process;

end simple;