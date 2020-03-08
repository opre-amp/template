 /*
  * This module approximates the square root of an unsigned 32bit
  * number. The algorithm works by doing a bit-wise binary search.
  * Starting from the most significant bit, the accumulated value
  * tries to put a 1 in the bit position. If that makes the square
  * to big for the input, the bit is left zero, otherwise it is set
  * in the result. This continues for each bit, decreasing in
  * significance, until all the bits are calculated or all the
  * remaining bits are zero.
  *
  * Since the result is an integer, this function really calculates
  * value of the expression:
  *
  *      x = floor(sqrt(y))
  *
  * where sqrt(y) is the exact square root of y and floor(N) is the
  * largest integer <= N.
  *
  * For 32 bit numbers, this will never run more than 16 iterations,
  * which amounts to 16 clocks.
  */

module sqrt32(clk, rdy, reset, x, .y(acc));
   input  clk;
   output rdy;
   input  reset;

   input [31:0] x;
   output [15:0] acc;


   // acc holds the accumulated result, and acc2 is the accumulated
   // square of the accumulated result.
   reg [15:0] acc;
   reg [31:0] acc2;

   // Keep track of which bit I'm working on.
   reg [4:0]  bitl;
   wire [15:0] bit = 1 << bitl;
   wire [31:0] bit2 = 1 << (bitl << 1);

   // The output is ready when the bitl counter underflows.
   wire rdy = bitl[4];

   // guess holds the potential next values for acc, and guess2 holds
   // the square of that guess. The guess2 calculation is a little bit
   // subtle. The idea is that:
   //
   //      guess2 = (acc + bit) * (acc + bit)
   //             = (acc * acc) + 2*acc*bit + bit*bit
   //             = acc2 + 2*acc*bit + bit2
   //             = acc2 + 2 * (acc<<bitl) + bit
   //
   // This works out using shifts because bit and bit2 are known to
   // have only a single bit in them.
   wire [15:0] guess  = acc | bit;
   wire [31:0] guess2 = acc2 + bit2 + ((acc << bitl) << 1);

   task clear;
      begin
	 acc = 0;
	 acc2 = 0;
	 bitl = 15;
      end
   endtask

   initial clear;

   always @(reset or posedge clk)
      if (reset)
       clear;
      else begin
	 if (guess2 <= x) begin
	    acc  <= guess;
	    acc2 <= guess2;
	 end
	 bitl <= bitl - 1;
      end

endmodule