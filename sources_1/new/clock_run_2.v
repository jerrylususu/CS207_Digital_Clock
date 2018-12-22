`timescale 1ns / 1ps

// this is only for sitimulation

module clock_run_2(clk,rst,seg_en,seg_out,onehz,h1,h2,m1,m2,s1,s2);

input clk,rst;
output [7:0] seg_en;
output [7:0] seg_out;

output onehz;
wire [16:0] seconds;
wire rst;
output [3:0] h1,h2,m1,m2,s1,s2;

reg [7:0] en = 8'b1111111;

gene_1hz gen(clk,rst,onehz);
time_goes_by sec_cnt(seconds,onehz,rst);
time_convert conv(seconds,h1,h2,m1,m2,s1,s2);
display disp(clk,0,0,h1,h2,m1,m2,s1,s2,en,seg_en,seg_out);

endmodule
