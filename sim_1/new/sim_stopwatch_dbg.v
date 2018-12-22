`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 14:29:24
// Design Name: 
// Module Name: sim_stopwatch_dbg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_stopwatch_dbg();

reg clk;
reg btn;
reg rst=0;

wire [7:0] seg_en,segout;
wire [3:0] q7,q6,q5,q4,q3,q2,q1,q0;
wire runstate;

wire [25:0] timerec;
wire tenmhz;
wire [16:0] seconds;
wire [6:0] mms;

stopwatch_dbg u(clk,btn,rst,seg_en,seg_out,q7,q6,q5,q4,q3,q2,q1,q0,runstate,timerec,tenmhz,seconds,mms);

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
#100 btn = 1;
#20 btn = 0;
end

endmodule
