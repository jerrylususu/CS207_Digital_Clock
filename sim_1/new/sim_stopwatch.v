`timescale 1ns / 1ps

module sim_stopwatch();

reg clk;
reg btn;
reg rst=0;

wire [7:0] seg_en,segout;
wire [3:0] q7,q6,q5,q4,q3,q2,q1,q0;
wire runstate;

stopwatch u(clk,btn,rst,seg_en,seg_out,q7,q6,q5,q4,q3,q2,q1,q0,runstate);

initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin
btn = 0;
#3 btn = 1;
#50 btn = 0;
#50 btn = 1;
#20 btn = 0;
end

endmodule
