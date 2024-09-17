/* 
	Author: Adam Friesz
	Date: 5/3/24
	This is a wrapper for the binary search algorithm implemented in bs.sv that
	allows user interaction with the DE1-SoC board. 
	
	inputs -
		CLOCK_50: clock to run off of
		SW[9:0]: SW[7] -> SW[0] specify the number to search for
		KEY[3:0]: KEY[0] resets the machine, KEY[3] starts the counting
		
	outputs - 
		HEX1, HEX0 - the HEXs display the address of given number, if found
		LEDR[9:0]: LEDR[9] is high if the searching is done
					  LEDR[0] is high if the input was found
*/
module task2 (CLOCK_50, SW, KEY, HEX0, HEX1, LEDR);
	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [6:0] HEX0;
	output logic [6:0] HEX1;
	output logic [9:0] LEDR;

	logic clk, Start, Reset;
	logic [7:0] A;
	logic Done, Found;
	logic [4:0] Loc;
	
	logic r1, r2, s1, s2;

	assign clk = CLOCK_50;
	assign A = {SW[7], SW[6], SW[5], SW[4], SW[3], SW[2], SW[1], SW[0]};
	
	// filter for metastability
	always_ff @(posedge clk) begin
		r1 <= ~KEY[0];
		r2 <= r1;
		
		s1 <= ~KEY[3];
		s2 <= s1;
	end
	
	// connect board inputs and outputs to the bit counting module	
	assign Reset = r2;
	assign Start = s2;
		
	assign LEDR[9] = Done;
	assign LEDR[0] = Found;
	
	logic [3:0] digit1, digit2;
	
	assign digit1 = Loc % 10;
	assign digit2 = Loc / 10;
	
	seg7_en disp2 (.hex(digit2), .en(Found), .leds(HEX1));
	seg7_en disp1 (.hex(digit1), .en(Found), .leds(HEX0));
	
	bs binary_search (.*);
	
endmodule  // task2
