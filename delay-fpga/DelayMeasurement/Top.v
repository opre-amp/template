`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:17:20 03/08/2020 
// Design Name: 
// Module Name:    Top 
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
module Top(
	 input rstbt,
    input [3:0] bt,
    input clk16M,
    output [7:0] seg_n,
    output [3:0] dig_n,
    output [4:0] col_n,
	 output [7:0] ld,
	 inout [14:13] aio
    );
	 reg [25:0] sum = 0;
	 reg [41:0] sqsum = 0;
	 reg [10:0] count = 0;
	 reg [15:0] min = 16'hDEAD;
	 reg [15:0] max = 16'hDEAD;
	 
	 reg [15:0] avg = 16'hDEAD;
	 reg [51:0] var = 16'hDEAD;
	 reg [15:0] number_display = 16'hDEAD;
	 
	 reg [7:0] ld_source = 0;
	 
	 reg enable = 0;
	 reg enable_display = 1;
	 wire signal;
	 wire signal_in; assign signal_in = ~aio[14];
	 wire ready;
	 wire [15:0] number;
	 wire [3:0] dig;
	 wire [7:0] seg;
	 
	 SIGNAL_GEN gen(.clk(clk16M), .signal(signal));
	 TIME t(.clk(clk16M), .t_start(signal), .t_end(signal_in), .number(number), .ready(ready));
	 DISPL_4DIG displ(.clk(clk16M), .en(enable_display), .number(number_display), .dig(dig), .seg(seg));
	 
	 always @(posedge clk16M)
	 begin
	 
		 if(rstbt)
		 begin
			enable = 1;
			max = 0;
			min = 16'hFFFF;
			sum = 0;
			sqsum = 0;
			count = 0;
			enable_display = 0;
			ld_source = 4'b0000;
		 end
		 
		 if(ready & enable)
		 begin
			sum = sum + number;
			sqsum = sqsum + number*number;
			count = count + 1;
			if(max<number) max = number;
			if(min>number) min = number;
			
		 end
		 
		 if(count == 11'd1024 & enable)
		 begin
			enable = 0;
			avg = sum/1024;
			var = sqsum/1024 - sum*sum/1024/1024;
			enable_display = 1;
			ld_source = 4'b0001;
			number_display = avg;
		 end
		 
		 if(enable_display)
		 begin
		 
			 if(bt[0]) begin ld_source = 4'b0001; number_display = avg; end
			 if(bt[2]) begin ld_source = 4'b0100; number_display = min; end
			 if(bt[3]) begin ld_source = 4'b1000; number_display = max; end
			 if(bt[1])
			 begin
				ld_source = 4'b0010;
				if(var[51:16]) 
				begin
					ld_source[7:4] = 4'b1111;
					number_display = 0;
				end
				else number_display = var;
			end
		 
		 end
	 
	 end

	 //outputs
	 
	 assign col_n = 5'b11111;
	 assign dig_n = ~dig;
	 assign seg_n = ~seg;
	 assign ld = ld_source;
	 assign aio[13] = ~signal & enable;

endmodule
