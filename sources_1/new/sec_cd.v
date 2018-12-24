`timescale 1ns / 1ps

//  countdown 1s per clk pulse
//  run no matter whether coundown is display (no en restriction)

module sec_cd(
    input clk, clk_1Hz, rst, clear, state,
    output reg [16:0] seconds
    );
    always @(posedge clk_1Hz, negedge rst)
    begin
        if ((~rst) || (clear))
            seconds <= 17'd0;
        else
        begin
            if (state)  //  running
                if (seconds != 17'd0)
                    seconds <= seconds - 1'b1;
        end
    end
endmodule