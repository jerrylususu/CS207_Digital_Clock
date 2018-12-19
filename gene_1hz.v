`timescale 1ns / 1ps
//generate a signal of 1hz form the default clock

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
