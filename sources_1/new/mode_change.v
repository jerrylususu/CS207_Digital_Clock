`timescale 1ns / 1ps

// try to get a mode change

// modes
// 1: clock_display
// 2: stopwatch
// 3. countdown
// 4. alarm set
// 5. clock set

module mode_change(clk,btn,buzzer,mode,seg_en,seg_num);

input clk,btn;
output buzzer;
output [2:0] mode;
output [7:0] seg_en,seg_num;



endmodule
