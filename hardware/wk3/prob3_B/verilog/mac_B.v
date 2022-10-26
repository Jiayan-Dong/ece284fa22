// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
// Hw4 Q3
// Student name: Jiayan Dong
// PID: A16593051
// Date: 10/26/2022

module mac (out, a0, a1, a2, a3, b0, b1, b2, b3, c);

parameter bw = 4;
parameter psum_bw = 16;

input [bw-1:0] a0; // unsigned activation
input [bw-1:0] a1; // unsigned activation
input [bw-1:0] a2; // unsigned activation
input [bw-1:0] a3; // unsigned activation

input signed [bw-1:0] b0; // signed weight
input signed [bw-1:0] b1; // signed weight
input signed [bw-1:0] b2; // signed weight
input signed [bw-1:0] b3; // signed weight

input signed [psum_bw-1:0] c; // old_psum

output signed [psum_bw-1:0] out; // psum

assign out = (($signed({1'b0, a0}) * b0 + $signed({1'b0, a1}) * b1)
 + ($signed({1'b0, a2}) * b2 + $signed({1'b0, a3}) * b3))
 + c;  

endmodule
