`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/14 18:04:18
// Design Name: 
// Module Name: sim_buzz
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_buzz();

reg clk;
wire spek;

wire  [17:0] counter;
wire sound;

buzz1 u(clk,spek,counter,sound);

initial begin
clk =0;
forever
#1 clk = ~clk;
end

endmodule
