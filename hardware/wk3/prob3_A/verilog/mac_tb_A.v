// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
// Hw4 Q2
// Student name: Jiayan Dong
// PID: A16593051
// Date: 10/26/2022

module mac_tb;

parameter bw = 4;
parameter psum_bw = 16;

reg clk = 0;

reg  [bw-1:0] a;
reg  [bw-1:0] b;
reg  [psum_bw-1:0] c;
wire [psum_bw-1:0] out;
reg  [psum_bw-1:0] expected_out = 0;

integer w_file ; // file handler
integer w_scan_file ; // file handler

integer x_file ; // file handler
integer x_scan_file ; // file handler

integer x_dec;
integer w_dec;
integer i; 
integer u; 

function [3:0] w_bin ;
  input integer  weight ;
  begin

    if (weight>-1)
     w_bin[3] = 0;
    else begin
     w_bin[3] = 1;
     weight = weight + 8;
    end

    if (weight>3) begin
     w_bin[2] = 1;
     weight = weight - 4;
    end
    else 
     w_bin[2] = 0;

    if (weight>1) begin
     w_bin[1] = 1;
     weight = weight - 2;
    end
    else 
     w_bin[1] = 0;

    if (weight>0) 
     w_bin[0] = 1;
    else 
     w_bin[0] = 0;

  end
endfunction



function [3:0] x_bin ;
  input integer  activation ;
  begin
    activation = activation & 4'b1111;
    if (activation>7) begin
     x_bin[3] = 1;
     activation = activation - 8;
    end
    else begin
     x_bin[3] = 0;
    end

    if (activation>3) begin
     x_bin[2] = 1;
     activation = activation - 4;
    end
    else begin
     x_bin[2] = 0;
    end

    if (activation>1) begin
     x_bin[1] = 1;
     activation = activation - 2;
    end
    else begin
     x_bin[1] = 0;
    end

    if (activation>0) 
     x_bin[0] = 1;
    else 
     x_bin[0] = 0;

  end

endfunction


// Below function is for verification
function [psum_bw-1:0] mac_predicted;
  input [bw-1:0] a;
  input signed [bw-1:0] b;
  input signed [psum_bw-1:0] c;

  mac_predicted = $signed({1'b0, a}) * b + c;

endfunction

mac_wrapper #(.bw(bw), .psum_bw(psum_bw)) mac_wrapper_instance (
	.clk(clk), 
        .a(a), 
        .b(b),
        .c(c),
	.out(out)
); 
 

initial begin 

  w_file = $fopen("b_data.txt", "r");  //weight data
  x_file = $fopen("a_data.txt", "r");  //activation

  $dumpfile("mac_tb.vcd");
  $dumpvars(0,mac_tb);
 
  #1 clk = 1'b0;  
  #1 clk = 1'b1;  
  #1 clk = 1'b0;

  $display("-------------------- Computation start --------------------");
  

  for (i=0; i<20; i=i+1) begin  // Data lenght is 20 in the data files

     #1 clk = 1'b1;
     #1 clk = 1'b0;

     w_scan_file = $fscanf(w_file, "%d\n", w_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x_dec);

     a = x_bin(x_dec); // unsigned number
     b = w_bin(w_dec); // signed number
     c = expected_out;

     expected_out = mac_predicted(a, b, c);

  end



  #1 clk = 1'b1;
  #1 clk = 1'b0;

  $display("-------------------- Computation completed --------------------");

  #10 $finish;


end

endmodule




