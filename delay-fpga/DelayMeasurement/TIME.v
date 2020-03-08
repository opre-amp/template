`timescale 1ns / 1ps
/* Measures elapsed time between two signals.
 * The `number` is the number of positive edges of the clock signal.
 */

module TIME(
    input clk,
    input t_start,
    input t_end,
	 output [15:0] number,
	 output ready
    );
	reg [15:0] counter = 0;
	reg [15:0] start = 0;
	
	reg [15:0] out_reg = 16'hDEAD;
	assign number = out_reg;

	reg ready_source = 0;
	assign ready = ready_source;
	
	reg last_t_start = 1;
	reg last_t_end = 1;
	
	always @(posedge clk)
	begin
		counter = counter + 1;
		
		if (~last_t_end & t_end & (counter - start < 16'h8000))
		begin
			ready_source <= 1;
			out_reg <= counter - start;
		end
		else ready_source <= 0;
		
		if (~last_t_start & t_start) start <= counter;
		
		last_t_end <= t_end;
		last_t_start <= t_start;
	end
	

endmodule
