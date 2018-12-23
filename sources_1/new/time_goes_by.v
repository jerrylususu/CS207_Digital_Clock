`timescale 1ns / 1ps

module time_goes_by(seconds,clk,reset);
//output reg [16:0] seconds=3580;
output reg [16:0] seconds=0;
input clk,reset;
always @(posedge clk) begin 
    if(reset) seconds<=0;
    else if(seconds==86400) seconds<=0;
    else seconds<=seconds+1;
end

endmodule
