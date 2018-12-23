`timescale 1ns / 1ps

// this tries to do the read and write test on a hardward

module hw_rw_do(clk, btn, in, out);

input clk, btn;
input [1:0] in;

output reg [1:0] out=0;

always @(posedge clk)
    if(btn)
        out <= in+1;

endmodule
