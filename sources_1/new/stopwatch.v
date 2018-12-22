`timescale 1ns / 1ps

// try to do a stopwatch

// sp for start/pause

//module stopwatch(clk,sp,rst,seg_en,seg_out,q7,q6,q5,q4,q3,q2,q1,q0,runstate);
module stopwatch(clk,sp,rst,seg_en,seg_out);

input clk,sp,rst;
output [7:0] seg_en,seg_out;

reg runstate=0;
wire [3:0] q7,q6,q5,q4,q3,q2,q1,q0;

//output reg runstate=0;
//output [3:0] q7,q6,q5,q4,q3,q2,q1,q0;

wire tenmhz;

reg [25:0] timerec=0; 
// 2^26 = 134217728

// 0 for stop and 1 for run

gen_10mhz gen(clk,tenmhz);

//wire [3:0] q7,q6,q5,q4,q3,q2,q1,q0;
bin2dec8 conv(timerec,q7,q6,q5,q4,q3,q2,q1,q0);
display disp(clk,q7,q6,q5,q4,q3,q2,q1,q0,8'hff,seg_en,seg_out);

always @(posedge clk) begin
    if(rst) timerec<=0;
    else if(runstate==0) timerec<=timerec;
    else if(timerec==1_0000_0000) timerec<=0;
    else timerec<=timerec+1;
end

wire button_fixed;
button_jitter jit(clk,sp,button_fixed);

always @(posedge button_fixed) begin
    runstate = ~runstate;
end

endmodule
