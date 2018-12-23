`timescale 1ns / 1ps

// wraps the alarm and do check
// force the alarm to be at 10s

module alarm_wrap(clk,rst,btn,speaker,onehz,seg_en,seg_out);

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

wire sound;

alarm al(1,onehz,cur_sec,tar_sec,len,btn,sound);
liangzhu so(speaker,clk,sound);

endmodule
