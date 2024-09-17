/* 
	Author: Adam Friesz
	Date: 5/3/2024
	
	This is the datapath for the bs module which implements the binary search algorithm
	inputs -
		clk: clock to run off of
		A: the value to search for
		init: initialize values
		load_mid: update middle value
		load_right: update right value
		load_left: update left value
		set_found: update Found register
		set_mid: set middle value to left value
	outputs - 
		t_lt_mid: target is less than the middle value
		equal: value stored at middle value of RAM is equal to target
		l_lt_r: the left value is less than the right value
		Done: the search is completed
		Found: the given value was found
		Loc: the location the given value was found at, only valid if Found is true
*/
module bs_data (clk, init, load_mid, set_found, set_done, set_mid, load_right, load_left,
					 t_lt_mid, equal, l_lt_r,
					 Loc, Done, A, Found);
	
	input logic [7:0] A;
	input logic clk, init, load_mid, load_right, load_left, set_found, set_done, set_mid;
	output logic t_lt_mid, equal, l_lt_r, Done, Found;
	output logic [4:0] Loc;
	
	// datapath components
	logic [4:0] left, right, mid;
	logic [7:0] target, Data_out;
	
	ram32x8 regfile (.address(mid), .clock(clk), .data(1'b0), .wren(1'b0), .q(Data_out));
	
	// datapath logic (implement RTLs)
	always_ff@(posedge clk) begin
		if (init) begin
			target = A;
			left = 0;
			right = 31;
			Done = 0;
			Found = 0;
		end
		
		if (load_mid) 
			mid = (left+right)/2;
			
		if (load_left)
			left = mid + 1'b1;
			
		if (load_right)
			right = mid - 1'b1;
			
		if (set_found)
			Found = 1;
			
		if (set_done)
			Done = 1;
			
		if (set_mid)
			mid = left;
	end  // always_ff
	
	// output assignments
	assign t_lt_mid = target < Data_out;
	assign equal = target == Data_out;
	assign l_lt_r = left < right;
	assign Loc = mid;
	
endmodule  // bs_data
