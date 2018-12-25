`timescale 1ns / 1ps

module alarm_len_conved(enable,sec_clk,cur_sec,tar_sec,len_s,off,alarming);
input enable,sec_clk,off;
input [16:0] cur_sec,tar_sec;
input [1:0] len_s;
reg [5:0] len;
output reg alarming=0;
reg alarm_off=0;

always @ (posedge sec_clk) begin
    case(len_s)
        0: len = 15;
        1: len = 30;
        2: len = 45;
        3: len = 60;
    endcase
    if(enable)
        if( tar_sec-1 <= cur_sec && cur_sec <= tar_sec + len -1)
            begin
                if(alarm_off==0 && off==1)
                    alarm_off = 1;
                if(alarm_off==0)
                    alarming = 1;
                else
                    alarming = 0;
            end
        else begin
            alarming = 0;
            alarm_off = 0;
        end
end

endmodule
