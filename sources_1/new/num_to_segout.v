`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/19 12:00:05
// Design Name: 
// Module Name: num_to_segout
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


module num_to_segout(num, cdigit, en_p ,seg_out);
input [3:0] num;
input [3:0] cdigit;
input [7:0] en_p;
output [7:0] seg_out;

reg [6:0] seg_out1;
reg en_point;

assign seg_out = {en_point,seg_out1};

always @*
begin
    en_point = en_p[cdigit];
end

always @*
begin
    case(num)
        4'h0: seg_out1 = 7'b1000000;
        4'h1: seg_out1 = 7'b1111001;
        4'h2: seg_out1 = 7'b0100100;
        4'h3: seg_out1 = 7'b0110000;
        4'h4: seg_out1 = 7'b0011001;
        4'h5: seg_out1 = 7'b0010010;
        4'h6: seg_out1 = 7'b0000010;
        4'h7: seg_out1 = 7'b1111000;
        4'h8: seg_out1 = 7'b0000000;
        4'h9: seg_out1 = 7'b0010000;
        4'ha: seg_out1 = 7'b0001000;
        4'hb: seg_out1 = 7'b0000011;
        4'hc: seg_out1 = 7'b1000110;
        4'hd: seg_out1 = 7'b0100001;
        4'he: seg_out1 = 7'b0000110;
        4'hf: seg_out1 = 7'b0001110;
        default: seg_out1 = 7'b0000000;
    endcase
end

endmodule
