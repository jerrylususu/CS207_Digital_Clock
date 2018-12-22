`timescale 1ps / 1ps

module sim_clock();

reg clk = 0;
reg rst = 0;
wire [7:0] seg_en;
wire [7:0] seg_out;
wire onehz;
wire [3:0] h1,h2,m1,m2,s1,s2;

clock_run_2 u(clk,rst,seg_en,seg_out,onehz,h1,h2,m1,m2,s1,s2);

initial begin
clk = 0;
forever #1 clk = ~clk;
end

endmodule
