`timescale 1ns / 1ps


module rw_test_ram(clk,we,data);

input clk,we;
inout [5:0] data;
reg [5:0] data_out;
reg [5:0] mem;
assign data = (!we)?data_out : 6'bz;

always @(*) begin
    if(we) begin
        mem <= data;
    end else
        data_out <= mem;
end

endmodule
