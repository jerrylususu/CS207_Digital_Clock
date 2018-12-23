`timescale 1ns / 1ps

// this does the test

module rw_test_do(clk,in,out,en);

input clk,en;
input [5:0] in;
output reg [5:0] out;

reg [5:0] tmp;

always @ (posedge clk) begin
    if(en) begin
    tmp = in;
    out = tmp+1; end
end
endmodule
