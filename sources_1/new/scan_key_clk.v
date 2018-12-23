`timescale 1ns / 1ps


module scan_key_clk(
    input clk, rst,
    output key_clk  //  modified clock for keyboard scanning
    );
    //  want to scan for 20ms each (50Hz) --> 10^8 / 50 / 2 --> 1e6 --> 2^20
    reg [19:0] cnt;
    always @(posedge clk, negedge rst)
    begin
        if (~rst)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
    assign key_clk = cnt[19];   //  MSB can perform as a clk pulse
endmodule