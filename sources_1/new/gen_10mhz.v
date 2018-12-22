`timescale 1ns / 1ps

// tries to gen 10mhz

module gen_10mhz(clk,out);

input clk;
output reg out=0;

reg [1:0] cnt=0;
always @ (posedge clk)
if(cnt==4)
    begin
    cnt <= 0;
    out <= ~out;
    end
else
    cnt <= cnt+1;


endmodule
