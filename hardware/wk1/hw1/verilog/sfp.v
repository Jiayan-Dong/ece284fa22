// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
// Student name: Jiayan Dong
// PID: A16593051
// Date: 10/3/2022
module sfp (out, in, thres, acc, relu, clk, reset);

parameter bw = 4;
parameter psum_bw = 16;

input clk;
input acc;
input relu;
input reset;

input signed [bw-1:0] in;
input signed [psum_bw-1:0] thres;

output  signed [psum_bw-1:0] out;

reg  signed [psum_bw-1:0] psum_q;

// Your code goes here

wire signed  [psum_bw-1:0] next_psum_q;

assign out     = psum_q;

always @ (posedge clk or posedge reset) begin
        if (reset) begin
            psum_q  <= 0;
        end else begin
            if (acc == 1)
                psum_q  <= psum_q + in;
            else if ((relu == 1) && (psum_q < thres))
                psum_q  <= 0;
        end
end

endmodule
