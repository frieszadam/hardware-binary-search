/* 
	Author: Adam Friesz
	Date: 5/3/2024

	This testbench thoroughly simulates the bs module, which implements
	a binary search algorithm.
	the $display command is used to simplify user verification.
*/
`timescale 1 ps / 1 ps
module bs_tb();

	// local signals
	logic clk, Start, Reset;
	logic [7:0] A;
	logic Done, Found;
	logic [4:0] Loc;
	
	
	// instantiate device under test
	bs dut(.*);
	
	// create simulated clock
	always begin
		clk = 1'b1; #5; clk = 1'b0; #5;
	end
	
	// define test inputs
	initial begin
		Reset = 1'b1; Start = 1'b0; A = 0; @(posedge clk);
		Reset = 1'b0; 	   @(posedge clk);
		
		// 1 -> 32 are stored in RAM at address = val-1
		// 0 and 33 are not in RAM so should print "... Found: 0. Location: -1"
		for (int i = 0; i <= 33; i++) begin
			A = i; 					@(posedge clk);
										@(posedge clk);
			Start = 1'b1;			@(posedge clk);
			Start = 1'b0; 			@(posedge Done);
			$display("Target: %2d 	Found: %s 	Location: %d", 
						A,  Found ? "YES": "NO", Found ? Loc : -1);
		end 
		$stop;
	end  // initial
endmodule  //  task1_tb
