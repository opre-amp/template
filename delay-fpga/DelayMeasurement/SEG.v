`timescale 1ns / 1ps
// source: https://www.mit.bme.hu/oktatas/targyak/vimiaa02/laborok-anyaga

module SEG(
    input      [3:0] digit,
    output     [7:0] seg
    );

	reg [6:0] segment;
	wire decp = 1'b0;

	always @(*)  
		begin
			case (digit)
				4'b0000 : segment = 7'b0111111;  // 0
				4'b0001 : segment = 7'b0000110;  // 1
				4'b0010 : segment = 7'b1011011;  // 2
				4'b0011 : segment = 7'b1001111;  // 3
				4'b0100 : segment = 7'b1100110;  // 4
				4'b0101 : segment = 7'b1101101;  // 5
				4'b0110 : segment = 7'b1111101;  // 6
				4'b0111 : segment = 7'b0000111;  // 7
				4'b1000 : segment = 7'b1111111;  // 8
				4'b1001 : segment = 7'b1101111;  // 9
				4'b1010 : segment = 7'b1110111;  // A
				4'b1011 : segment = 7'b1111100;  // B
				4'b1100 : segment = 7'b0111001;  // C
				4'b1101 : segment = 7'b1011110;  // D
				4'b1110 : segment = 7'b1111001;  // E
				4'b1111 : segment = 7'b1110001;  // F
			endcase
		end 
	 
	assign seg = {decp,segment};

endmodule
