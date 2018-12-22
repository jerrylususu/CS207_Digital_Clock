`timescale 1ns / 1ps

// tries to gen 25mhz

module gen_25mhz(clk,out);

input clk;
output reg out=0;

reg [1:0] cnt=0;
always @ (posedge clk)
if(cnt==3)
    begin
    cnt <= 0;
    out <= ~out;
    end
else
    cnt <= cnt+1;


endmodule
