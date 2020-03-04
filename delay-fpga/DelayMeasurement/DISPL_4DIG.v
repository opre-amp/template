`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:19 02/24/2020 
// Design Name: 
// Module Name:    DISPL_4DIG 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DISPL_4DIG(
	 input clk,
	 input en,
	 input [15:0] number,
	 output [3:0] dig,
	 output [7:0] seg
    );
	
	reg [3:0] dig_r = 1;
	assign dig = dig_r;
	
	reg [3:0] digit_r = 0;
	wire [3:0] digit;
	assign digit = digit_r;

	reg [9:0] clock_counter = 0;
	always @ (posedge clk)
	begin
		if(en)
		begin
			if(clock_counter == 0)
			begin
				dig_r = dig_r[3] ? 1 : {dig_r[2:0],1'b0};
				case(dig_r)
					1: digit_r = number[3 :0 ];
					2: digit_r = number[7 :4 ];
					4: digit_r = number[11:8 ];
					8: digit_r = number[15:12];
				endcase
			end
			clock_counter = clock_counter + 1;
		end
	end
	
	SEG segment(.digit(digit), .seg(seg));


endmodule
