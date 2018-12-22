`timescale 1ns / 1ps

// try to do a stopwatch

// sp for start/pause

//module stopwatch(clk,sp,rst,seg_en,seg_out,q7,q6,q5,q4,q3,q2,q1,q0,runstate);
module stopwatch_dbg(clk,sp,rst,seg_en,seg_out,q7,q6,q5,q4,q3,q2,q1,q0,runstate,timerec,tenmhz,seconds,mms);

input clk,sp,rst;
output [7:0] seg_en,seg_out;

output reg runstate=0;
output [3:0] q6,q5,q4,q3,q2;
output [3:0] q1,q0,q7;

//output reg runstate=0;
//output [3:0] q7,q6,q5,q4,q3,q2,q1,q0;

output tenmhz;

output reg [25:0] timerec=0; 
// 2^26 = 134217728

// 0 for stop and 1 for run

gen_10mhz gen(clk,tenmhz);

//wire [3:0] q7,q6,q5,q4,q3,q2,q1,q0;

output [16:0] seconds;
assign seconds = timerec/100;
output [6:0] mms;
assign mms = timerec%100;

wire tmp1,tmp2,tmp3,tmp4,tmp5,tmp6;

bin2dec8 convmm({19'd0,mms},tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,q1,q0);
time_convert convsec(seconds,q7,q6,q5,q4,q3,q2);
display disp(clk,q7,q6,q5,q4,q3,q2,q1,q0,8'hff,seg_en,seg_out);

always @(posedge tenmhz) begin
    if(rst) timerec=0;
    else if(runstate==0) timerec=timerec;
    else if(timerec==1_0000_0000) timerec=0;
    else timerec=timerec+1;
end

wire button_fixed;
button_jitter jit(clk,sp,button_fixed);

always @(posedge button_fixed) begin
    runstate = ~runstate;
end

endmodule