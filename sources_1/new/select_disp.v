`timescale 1ns / 1ps

module select_disp(open,en1,out1,en,out);

input [7:0] open;
input [7:0] en1,out1;
output [7:0] en,out;

assign en = (open)&(en1);
assign out = (open)&(out1);

endmodule
