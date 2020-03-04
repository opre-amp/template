`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:41:24 02/24/2020 
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
    input [3:0] bt,
    input clk16M,
    output [7:0] seg_n,
    output [3:0] dig_n,
    output [4:0] col_n,
	 output [3:0] ld,
	 inout [14:13] aio
    );
	 reg [25:0] sum = 0;
	 reg [15:0] avg = 16'hDEAD;
	 reg [15:0] min = 16'hDEAD;
	 reg [15:0] max = 16'hDEAD;
	 reg [15:0] number_display = 16'hDEAD;
	 
	 wire [15:0] number;
	 wire [3:0] dig;
	 wire [7:0] seg;
	 wire signal;
	 wire ready;
	 wire finished;
	 reg enable_display = 1;
	 reg[3:0] ld_src;
	 assign ld = ld_src;
	 
	 assign aio[13] = ~signal;
	 SIGNAL_GEN gen(.clk(clk16M), .start(bt[0]), .signal(signal), .finished(finished));
	 TIME T(.clk(clk16M), .t_start(signal), .t_end(aio[14]), .number(number), .ready(ready));
	 
	 reg [15:0] number_perm;
	 reg handled = 0;
	 reg [10:0] handled_counts = 0;
	 always @(posedge clk16M)
	 begin
		number_perm = number;
		if(bt[0])
		begin
			enable_display = 0;
			sum = 0;
			min = ~(16'b0);
			max = 0;
			ld_src = 1;
			handled_counts = 0;
		end
		
		if(ready & ~handled & handled_counts < 1024)
		begin
			handled_counts = handled_counts + 1;
			handled = 1;
			sum = sum + number_perm;
			if(number_perm > max) max = number_perm;
			if(number_perm < min) min = number_perm;
		end
		else if(~ready) handled = 0;
		
		if(finished && ld[0])
		begin
			enable_display = 1;
			avg = sum[25:10];
			number_display = avg;
			ld_src = 2;
		end
		
		if(bt[1]) begin number_display = avg; ld_src = 2; end
		if(bt[2]) begin number_display = min; ld_src = 4; end
		if(bt[3]) begin number_display = max; ld_src = 8; end
	 end
		
	 
	 DISPL_4DIG displ(.clk(clk16M), .en(enable_display), .number(number_display), .dig(dig), .seg(seg));
	 
	 assign col_n = 5'b11111;
	 assign dig_n = ~dig;
	 assign seg_n = ~seg;
	 


endmodule
