// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac (out, a, b, c);

parameter bw = 4;
parameter psum_bw = 16;

input [bw-1:0] a; // unsigned activation
input signed [bw-1:0] b; // signed weight
input signed [psum_bw-1:0] c; // old_psum

output signed [psum_bw-1:0] out; // psum

assign out = $signed({1'b0, a}) * b + c;  

endmodule
