/* 
	Author: Adam Friesz
	Date: 5/3/2024

	This module implements a binary search algorithm by combining control and datapath units. 
	input signals - 
		A: number to search for.
		Start: signal to start searching
			Reset: reset the machine
	outputs - 
		Done: signal that the search is completed
		Found: if high the given value (A) has been found.
		Loc: location at which the given value was found - only valid if Found is true.
*/
module bs (clk, A, Start, Reset, Loc, Done, Found);
	input logic clk, Start, Reset;
	input logic [7:0] A;
	output logic Done, Found;
	output logic [4:0] Loc;
	
	// status and control signals
	logic init, load_right, load_left, load_mid, set_found, set_done, set_mid;
	logic t_lt_mid, equal, l_lt_r, l_eq_r;
	
	// instaniate and connect datapath + control
	bs_ctrl c_unit (.*);
	bs_data d_unit (.*);
	
endmodule  // bs
