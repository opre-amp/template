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
	
	reg last_t_end = 1;
	reg [15:0] out_reg = 16'hDEAD;
	assign number = out_reg;
	
	reg [2:0] ready_counter = 0;
	reg ready_source = 0;
	assign ready = ready_source;
	
	always @(posedge clk)
	begin
		counter = counter + 1;
		if (last_t_end & ~t_end)
		begin
			ready_source = 1;
			out_reg = counter - start;
			ready_counter = 1;
		end
		if(ready_counter == 0) ready_source = 0;
		else ready_counter = ready_counter + 1;
		last_t_end <= t_end;
	end

	always @(posedge t_start)
		start <= counter;
	

endmodule
