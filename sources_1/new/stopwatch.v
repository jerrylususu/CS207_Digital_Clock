`timescale 1ns / 1ps

module stopwatch(clk,sp,rst,seg_out,seg_en,seconds);

input clk,sp,rst;
output [7:0] seg_en,seg_out;

reg runstate=0;
wire [3:0] q7,q6,q5,q4,q3,q2,q1,q0;

wire tenmhz;
gen_10mhz gen(clk,tenmhz);

reg [25:0] timerec=0;
output [16:0] seconds;
wire [6:0] mms;

assign seconds = timerec/100;
assign mms = timerec%100;

wire tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;

bin2dec8 convmm({19'd0,mms},tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,q1,q0);
sec2bcd convsec(seconds,q7,q6,q5,q4,q3,q2);
display disp(clk,q7,q6,q5,q4,q3,q2,q1,q0,8'hff,seg_en,seg_out);

always @(posedge tenmhz) begin
    if(rst) timerec<=0;
    else
        if(runstate==1)
            if(timerec==1_0000_0000)
                timerec<=0;
            else
                timerec<=timerec+1;
end

wire btn_fixed;
button_jitter jit(clk,sp,btn_fixed);

always @(posedge btn_fixed)
    runstate = ~runstate;


endmodule