`timescale 1ns / 1ps

module SIGNAL_GEN(
		input clk,
		output signal
    );
	 
	 reg [15:0] counter = 0;
	 reg signal_source = 0;
	 assign signal = signal_source;
	 
	 always @(posedge clk)
	 begin
	 
		 counter = counter + 1;
		 if(counter == 16'h8000) signal_source = 1;
		 if(counter == 0) signal_source = 0;
	 
	 end


endmodule
