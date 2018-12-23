`timescale 1ns / 1ps

// this will alarm for hours

module hour_check(clk,en,cur_sec,speaker);

input clk,en;
input [16:0] cur_sec;
output reg speaker;

reg [11:0] sec;

reg [15:0] counter=0;
always @(posedge clk) counter <= counter+1;


always @ (posedge clk) begin
    if(en) begin
    sec = cur_sec % 3600;
    if((3592 <= sec && sec <= 3599)||(sec == 0)) begin
        if(sec ==3592 ||sec==3594||sec==3596||sec==3598)
            speaker = counter[15];
        else if (sec==0)
            speaker = counter[14];
        else
            speaker = 0;
    end 
    end
end


endmodule
