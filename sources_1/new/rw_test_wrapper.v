`timescale 1ns / 1ps


module rw_test_wrapper(clk,out,in,en);

input clk,en;
output reg [5:0] out=0;

output [5:0] in;

rw_test_do u(clk,out,in,en);

always @(*) begin
    out <= in;
end

endmodule
