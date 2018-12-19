`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2018 12:03:12 PM
// Design Name: 
// Module Name: gene_1hz
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


module gene_1hz(clk_100mhz,rst_100mhz,out_1hz);
input clk_100mhz,rst_100mhz;
reg [20:0] count_reg = 0;
output reg out_1hz = 0;

always @(posedge clk_100mhz or posedge rst_100mhz) begin
    if (rst_100mhz) begin
        count_reg <= 0;
        out_1hz <= 0;
    end else begin
        if (count_reg < 49999999) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= 0;
            out_1hz <= ~out_1hz;
        end
    end
end
    
endmodule
