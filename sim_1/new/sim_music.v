`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/18 00:41:11
// Design Name: 
// Module Name: sim_music
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


module sim_music();

reg clk;
wire speaker;
wire [27:0] tone;
wire [8:0] clkdivider;
wire [8:0] counter_note;
wire [7:0] counter_octave;

music u(clk,speaker,tone, clkdivider, counter_note, counter_octave);

initial begin clk=0;
forever #4 clk = ~clk;
end



endmodule
