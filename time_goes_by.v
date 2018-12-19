`timescale 1ns / 1ps

module time_goes_by(seconds,clk,reset);
output reg [16:0] seconds;
input clk,reset;
    always @(posedge clk) begin 
        if(reset) seconds<=0;
        else seconds<=seconds+1;
    end

endmodule

