`timescale 1ns / 1ps

// tries to gen 0.01s -> 100hz

module gen_10mhz(clk,out);

input clk;
output reg out=0;

reg [18:0] cnt=0;
always @ (posedge clk)
if(cnt==499999)
    begin
    cnt <= 0;
    out <= ~out;
    end
else
    cnt <= cnt+1;


endmodule
