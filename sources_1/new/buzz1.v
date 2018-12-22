`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/14 12:31:17
// Design Name: 
// Module Name: buzz1
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


//module buzz1(clk,speaker,light);

//input clk;
//output speaker;
//output light;

//reg [17:0] counter=0;
//reg sound;
//always @(posedge clk) 
//if(counter==200000)
//begin
//    counter <= 0;
//    sound = 1;
//end
//else 
//begin
//    counter <= counter+1;
//    sound = 0;
//end

//assign speaker = sound;
//assign light = sound;

//endmodule


module buzz1(clk, speaker, light);
input clk;
output speaker, light;
parameter clkdivider = 100000000/440/2;

reg [23:0] tone;
always @(posedge clk) tone <= tone+1;

reg [14:0] counter;
always @(posedge clk) if(counter==0) counter <= (tone[23] ? clkdivider-1 : clkdivider/2-1); else counter <= counter-1;

reg speaker;
always @(posedge clk) if(counter==0) speaker <= ~speaker;
endmodule