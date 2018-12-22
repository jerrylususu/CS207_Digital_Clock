`timescale 1ns / 1ps

module clock_run(clk,rst,seg_en,seg_out,onehz);

input clk,rst;
output [7:0] seg_en;
output [7:0] seg_out;

output onehz;
wire [16:0] seconds;
wire rst;
wire [3:0] h1,h2,m1,m2,s1,s2;

reg [7:0] en = 8'b0111111;

gene_1hz gen(clk,0,onehz);
time_goes_by sec_cnt(seconds,onehz,rst);
time_convert conv(seconds,h1,h2,m1,m2,s1,s2);
display disp(clk,4'b0000,4'b0000,h1,h2,m1,m2,s1,s2,en,seg_en,seg_out);

endmodule
