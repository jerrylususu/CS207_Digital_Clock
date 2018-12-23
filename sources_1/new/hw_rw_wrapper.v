`timescale 1ns / 1ps

module hw_rw_wrapper(clk,btn,out,in,twotime);

input clk,btn;
output reg [1:0] out=0;

output twotime;

gen_freq #(.times(2)) u(clk,twotime);

output [1:0] in;
hw_rw_do du(twotime,btn,out,in);

always @(posedge clk)
    out = in;

endmodule
