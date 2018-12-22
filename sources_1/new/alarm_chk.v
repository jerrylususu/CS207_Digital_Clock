`timescale 1ns / 1ps

module alarm_chk(clk,h1,h2,seth1,seth2,out);
input clk;
input [3:0] h1,h2,seth1,seth2;
output reg out;

always @(posedge clk)
begin
if((h1==seth1)&&(h2==seth2))
    out <= 1;
else
    out <= 0;
end

endmodule
