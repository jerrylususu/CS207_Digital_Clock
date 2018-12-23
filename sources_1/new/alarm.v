`timescale 1ns / 1ps

module alarm(enable,sec_clk,cur_sec,tar_sec,len,off,alarming);
input enable,sec_clk,off;
input [16:0] cur_sec,tar_sec;
input [5:0] len;
output reg alarming=0;
reg alarm_off=0;

//always @(posedge off) alarm_off=1; 
//output reg alarm_on;
//always @(posedge sec_clk) begin 
//    if(cur_sec-tar_sec>len||cur_sec<tar_sec) alarm_off=0;

//    if(enable)  begin
//        if(cur_sec==tar_sec) begin 
//            alarming=1;
//        end
//        else if(cur_sec>tar_sec&&cur_sec-tar_sec<=len) begin 
//            if(alarm_off)
//                alarming=0;
//            else
//                alarming=1;
//        end
//    end 
//    else begin alarming=0; end   
//end

always @ (posedge sec_clk) begin
    if(enable)
        if( tar_sec <= cur_sec && cur_sec <= tar_sec + len)
            begin
                if(alarm_off==0 && off==1)
                    alarm_off = 1;
                if(alarm_off==0)
                    alarming = 1;
                else
                    alarming = 0;
            end
        else
            alarming = 0;
end

endmodule
