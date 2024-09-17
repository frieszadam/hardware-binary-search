/* 
	Author: Adam Friesz
	Date: 5/3/2024

	This is the controller for the bs module which implements the binary search algorithm
	inputs - 
		clk: clock to run off of
		Reset: reset the search
		Start: start searching
		t_lt_mid: target is less than the middle value
		equal: value stored at middle value of RAM is equal to target
		l_lt_r: the left value is less than the right value
	outputs -
		init: initialize values
		load_mid: update middle value
		load_right: update right value
		load_left: update left value
		set_found: update Found register
		set_mid: set middle value to left value
*/
module bs_ctrl (clk, Start, Reset,
					 init, load_mid, set_found, set_done, set_mid, load_right, load_left,
					 t_lt_mid, equal, l_lt_r);
	input logic clk, Start, Reset, t_lt_mid, equal, l_lt_r;
	output logic init, load_mid, set_found, set_done, set_mid, load_right, load_left;
	
	// define state names + vars
	enum {s_idle, s_init, s_search, s_load_mid, s_update_bounds, s_check_side_eq, s_check_side_eq2, s_done} ps,ns;
	
	// controller logic w/ synchronous reset
	always_ff @(posedge clk) begin
		ps <= Reset? s_idle: ns;
	end

	// next state logic
	always_comb begin
		case(ps)
			s_idle: ns = Start? s_init: s_idle;
			s_init: ns = s_search;
			s_search: begin
							if (equal)
								ns = s_done;
							 else if (~equal & ~l_lt_r)
								ns = s_check_side_eq;
							 else 
								ns = s_load_mid;
						 end
			s_load_mid: ns = s_update_bounds;
			s_update_bounds: ns = s_search;
			s_check_side_eq: ns = s_check_side_eq2;
			s_check_side_eq2: ns = s_done;
			s_done: ns = Start? s_done: s_idle;
		endcase
	end  // always_comb

	// output assignments, control signals
	assign init = (ps == s_idle) & Start;
	assign load_mid = init | (ps == s_search & l_lt_r & ~equal);
	assign load_left = (ps == s_update_bounds) & ~t_lt_mid;
	assign load_right = (ps == s_update_bounds) & t_lt_mid;
	assign set_found = ((ps == s_search) & equal) | (ps == s_check_side_eq2 & equal);
	assign set_done = (ps == s_done);
	assign set_mid = ps == s_search & ~equal & ~l_lt_r;

endmodule  // bs_ctrl
