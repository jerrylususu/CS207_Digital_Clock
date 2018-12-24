`timescale 1ns / 1ps

//  Main module of Project_Countdown

module countdown(
    input clk, rst, clk_1Hz,
    input toggle, clear, init_en,
    input run,pause,
    input [16:0] tar_sec,
    output reg [16:0] seconds,   //  current second status
    output reg buzzer = 0,
    output reg state = 0,   //  termination triggers buzzer(1)
    output reg [27:0] seccnt=0
    );

//    reg state = 0;  //  0: pause, 1: run
    
    
//    reg [16:0] seconds = 0;

    //  1. generate 1s clk pulse
//    wire clk_1Hz;
//    clk_1Hz clk_oneHz(clk, rst, state, clk_1Hz);    //  generate 1s clk pulse
    
    //  2. toggle state and buzzer
    always @(posedge clk)
    begin
        if(init_en) begin
            seconds <= tar_sec;
            state <= 0;
            seccnt <= 0;     
        end
        
        if(rst||clear) begin
            seccnt <= 0;
            state <= 0;
        end else begin
            if(state==1)
            if(seccnt < 1_0000_0000)
                seccnt <= seccnt +1;
            else begin
                seccnt <= 0;
                if(seconds>0)
                    seconds <= seconds - 1;
            end     
        end
        
      
        
        if ((rst) || (clear))  //  reset or clear, stop buzzing and stop running
        begin
            state <= 0;
            buzzer <= 0;
            seccnt <= 0;
            seconds <= 0;
        end
        else if (seconds == 17'd0 && state == 1)  //  termination triggers stop and buzzer
        begin
            state <= 0;
            buzzer <= 1;
        end
        
        if(state==0)
            buzzer <= 0;
        if(state==1&&rst) begin
            state <= 0;
            buzzer <=0;
        end    
            
        if (run==1&&pause==0)
            state <= 1;
        if (run==0&&pause==1)
            state <=0;
         
    end
    
    //  3. second countdown
//    sec_cd countdown(clk, clk_1Hz, rst, clear, state, seconds);
    
endmodule
