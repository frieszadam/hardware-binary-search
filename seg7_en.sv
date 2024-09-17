/* 
	Author: Adam Friesz
	Date: 5/3/24

	Basic 7-segment display driver for hex digits 0-F.
	Takes 4-bit input hex and outputs 7-bit leds if en is true,
	otherwise turns all segments off.
	
	LED segments are active low:
	   -0-
	  5   1
	   -6-
	  4   2
	   -3-
 */
module seg7_en (hex, en, leds);
	input  logic [3:0] hex;
	input logic en;
	output logic [6:0] leds;

	logic [6:0] num;
	always_comb begin
		case (hex)
			//       Light: 6543210
			4'h0: num = 7'b1000000;
			4'h1: num = 7'b1111001;
			4'h2: num = 7'b0100100;
			4'h3: num = 7'b0110000;
			4'h4: num = 7'b0011001;
			4'h5: num = 7'b0010010;
			4'h6: num = 7'b0000010;
			4'h7: num = 7'b1111000;
			4'h8: num = 7'b0000000;
			4'h9: num = 7'b0010000;
			4'hA: num = 7'b0001000;
			4'hB: num = 7'b0000011;
			4'hC: num = 7'b1000110;
			4'hD: num = 7'b0100001;
			4'hE: num = 7'b0000110;
			4'hF: num = 7'b0001110;
      endcase
	end  // always_comb
		
	assign leds = en ? num: 7'b1111111;
endmodule  // seg7_en
