`timescale 1ns / 1ps

module sim_alarm();

reg sec_clk;
reg [16:0] cur_sec, tar_sec;
reg [5:0] len;
reg off;
wire alarming;

alarm u(1,sec_clk,cur_sec,tar_sec,len,off,alarming);

initial begin
    sec_clk = 0;
    forever #1 sec_clk = ~sec_clk;
end

initial begin
    cur_sec = 0;
    forever #2 cur_sec = cur_sec+1;
end

initial begin
    tar_sec = 10;
    len = 20;
    off = 0;
    #60 off = 1;
    #5 off = 0;
    #10 off = 1;
    #5 off = 0;
end

endmodule
