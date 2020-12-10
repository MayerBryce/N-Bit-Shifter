entity lab3_testbench is
end lab3_testbench;

architecture behavior of lab3_testbench is

  -- define the maximum delay for the DUT
  constant MAX_DELAY : time := 20 ns;
  constant N_sig : integer := 8;
  
  -- define signals that connect to DUT
  signal in1_sig       : bit_vector(0 to 7);
  signal Mode_sig      : bit_vector(0 to 1);
  signal Shift_in_sig  : bit;
  signal OutN_sig      : bit_vector(0 to 7);
  signal Shift_out_sig : bit;
  
  type output_value_array is array (1 to 10) of bit_vector (0 to N_sig-1);
  constant OutN_sig_vals : output_value_array := ("10100101","01001010","01010010","01110101","10011101","00000000","01000000","10101010","00000000","01111000");
  constant Shift_out_sig_vals : bit_vector(1 to 10) := ('1','1','1','0','0','0','1','0','0','0');
  
  begin
  
    -- this is the process that will generate the inputs
	-- this is the process that will generate the inputs
    stimulus : process
      begin
        in1_sig <=  "10100101" after 10 ns,
                    "10100101" after 20 ns,
                    "10100101" after 30 ns,
                    "00111010" after 40 ns,
                    "00111010" after 50 ns,
                    "11111111" after 60 ns,
                    "10000001" after 70 ns,
                    "01010101" after 80 ns,
                    "00001111" after 90 ns,
                    "11110000" after 100 ns;
				   
	    Mode_sig <= "00" after 10 ns,
					"01" after 20 ns,
					"10" after 30 ns,
					"01" after 40 ns,
					"10" after 50 ns,
					"11" after 60 ns,
					"10" after 70 ns,
					"01" after 80 ns,
					"11" after 90 ns,
					"10" after 100 ns;
					
		Shift_in_sig <= '1' after 10 ns,
						'0' after 20 ns,
						'0' after 30 ns,
						'1' after 40 ns,
						'1' after 50 ns,
						'1' after 60 ns,
						'0' after 70 ns,
						'0' after 80 ns,
						'1' after 90 ns,
						'0' after 100 ns;
		
        wait; -- stop the process to avoid an infinite loop
    end process stimulus;

    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.lab3(simple)
	  generic map(N => N_sig)
      port map(InN => in1_sig, Mode => Mode_sig, Shift_in => Shift_in_sig, OutN => OutN_sig, Shift_out => Shift_out_sig);
    
		monitor : process
        variable i : integer := 1;
			begin
				wait on in1_sig, Mode_sig, Shift_in_sig;
				wait for MAX_DELAY/4;
        
			assert OutN_sig = OutN_sig_vals(i)
			report "ERROR - incorrect value on OutN_sig"
			severity error;
        
			assert Shift_out_sig = Shift_out_sig_vals(i)
            report "ERROR - incorrect value on Shift_out_sig"
            severity error; 
            
			i := i + 1;
    
		end process monitor;
	
end behavior;