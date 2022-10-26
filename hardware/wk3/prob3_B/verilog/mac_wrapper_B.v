// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
// Hw4 Q3
// Student name: Jiayan Dong
// PID: A16593051
// Date: 10/26/2022

module mac_wrapper (clk, out, a0, a1, a2, a3, b0, b1, b2, b3, c);

parameter bw = 4;
parameter psum_bw = 16;

output [psum_bw-1:0] out;
input [bw-1:0] a0; // unsigned activation
input [bw-1:0] a1; // unsigned activation
input [bw-1:0] a2; // unsigned activation
input [bw-1:0] a3; // unsigned activation

input signed [bw-1:0] b0; // signed weight
input signed [bw-1:0] b1; // signed weight
input signed [bw-1:0] b2; // signed weight
input signed [bw-1:0] b3; // signed weight
input  [psum_bw-1:0] c;
input  clk;

reg    [bw-1:0] a_q[3:0];
reg    [bw-1:0] b_q[3:0];
reg    [psum_bw-1:0] c_q;

mac #(.bw(bw), .psum_bw(psum_bw)) mac_instance (
        .a0(a_q[0]), 
        .a1(a_q[1]),
        .a2(a_q[2]),
        .a3(a_q[3]),
        .b0(b_q[0]),
        .b1(b_q[1]),
        .b2(b_q[2]),
        .b3(b_q[3]),
        .c(c_q),
	.out(out)
); 

always @ (posedge clk) begin
        b_q[0]  <= b0;
        b_q[1]  <= b1;
        b_q[2]  <= b2;
        b_q[3]  <= b3;
        a_q[0]  <= a0;
        a_q[1]  <= a1;
        a_q[2]  <= a2;
        a_q[3]  <= a3;
        c_q  <= c;
end

endmodule
