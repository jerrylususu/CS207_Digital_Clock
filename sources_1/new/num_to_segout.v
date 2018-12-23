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


module num_to_segout(num, seg_out);
input [3:0] num;
output reg [7:0] seg_out;

always @*
begin
    case(num)
        4'h0: seg_out = 8'b11000000;
        4'h1: seg_out = 8'b11111001;
        4'h2: seg_out = 8'b10100100;
        4'h3: seg_out = 8'b10110000;
        4'h4: seg_out = 8'b10011001;
        4'h5: seg_out = 8'b10010010;
        4'h6: seg_out = 8'b10000010;
        4'h7: seg_out = 8'b11111000;
        4'h8: seg_out = 8'b10000000;
        4'h9: seg_out = 8'b10010000;
        4'ha: seg_out = 8'b10001000;
        4'hb: seg_out = 8'b10000011;
        4'hc: seg_out = 8'b11000110;
        4'hd: seg_out = 8'b10100001;
        4'he: seg_out = 8'b10000110;
        4'hf: seg_out = 8'b10001110;
        default: seg_out = 8'b00000000;
    endcase
end

endmodule
