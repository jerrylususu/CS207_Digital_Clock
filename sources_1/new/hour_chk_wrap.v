`timescale 1ns / 1ps

// try to check hours

module hour_chk_wrap(clk,rst,btn,speaker,onehz,seg_en,seg_out);

input clk,rst,btn;
output speaker,onehz;
output [7:0] seg_en, seg_out;

wire [16:0] cur_sec;
reg [16:0] tar_sec = 10;
reg [5:0] len = 60;

wire [3:0] h1,h2,m1,m2,s1,s2;

gene_1hz gen(clk,0,onehz);
time_goes_by sec_cnt(cur_sec,onehz,rst);
time_convert conv(cur_sec,h1,h2,m1,m2,s1,s2);
display disp(clk,4'h0,4'h0,h1,h2,m1,m2,s1,s2,8'b00111111,seg_en,seg_out);

hour_check hc(clk,1,cur_sec,speaker);

endmodule
