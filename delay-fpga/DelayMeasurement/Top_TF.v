`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:13:47 03/08/2020
// Design Name:   Top
// Module Name:   /home/levente/Documents/opre-lab-amp/delay-fpga2/DelayFPGA/Top_TF.v
// Project Name:  DelayFPGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Top_TF;

	// Inputs
	reg rstbt;
	reg [3:0] bt;
	reg clk16M;

	// Outputs
	wire [7:0] seg_n;
	wire [3:0] dig_n;
	wire [4:0] col_n;
	wire [7:0] ld;

	// Bidirs
	wire [14:13] aio;
	
	reg aio14_source = 1;
	assign aio[14] = aio14_source;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.rstbt(rstbt), 
		.bt(bt), 
		.clk16M(clk16M), 
		.seg_n(seg_n), 
		.dig_n(dig_n), 
		.col_n(col_n), 
		.ld(ld), 
		.aio(aio)
	);

	initial begin
		// Initialize Inputs
		rstbt = 0;
		bt = 0;
		clk16M = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		rstbt = 1;
		#100;
		rstbt = 0;
        
		// Add stimulus here

	end
	
	always #62.5 clk16M = ~clk16M;
	
	
	always
	begin
		#300 aio14_source = aio[13];
	end
      
endmodule

