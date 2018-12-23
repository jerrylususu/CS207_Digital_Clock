`timescale 1ns / 1ps

// the main entry point

module main(clk,rst,
mode_btn,set_btn,toggle_btn,change_btn,
row,col,
seg_en,seg_out,
clk_en,sw_en, al_en,seconds,
keyboard_en);

input clk,rst,mode_btn,set_btn,toggle_btn,change_btn;
output [7:0] seg_en, seg_out;
input [3:0] row; output [3:0] col;
output reg clk_en, sw_en, al_en;
reg [1:0] cur_mode = 0;

wire onehz, tenmhz;

wire [16:0] main_seconds;

reg [16:0] clk_init_secs=0;
reg clk_init_en=0;

// core clock
gene_1hz g1(clk,rst,onehz);

time_goes_with_init sec_cnt(clk_init_secs,clk_init_en,main_seconds,onehz,rst);

wire mode_press;
button_jitter bj_mode(clk,mode_btn,mode_press);

wire toggle_press;
button_jitter bj_toggle(clk,toggle_btn,toggle_press);

wire set_press;
button_jitter bj_set(clk,set_btn,set_press);

reg [7:0] disp_en;
reg [3:0] d7,d6,d5,d4,d3,d2,d1,d0;
wire [7:0] u_seg_en, u_seg_out; // u for usual
display disp(clk,d7,d6,d5,d4,d3,d2,d1,d0,disp_en,u_seg_en,u_seg_out);

// read from keyboard
output reg keyboard_en = 0;
wire [7:0] keyboard_seg_en, keyboard_seg_out;
wire [3:0] kh1,kh2,km1,km2,ks1,ks2;
Display_from_keyboard_inputs keyin(clk,~rst,keyboard_en,
row,col,
keyboard_seg_en,keyboard_seg_out,
kh1,kh2,km1,km2,ks1,ks2);

// main state machine
always @ (posedge mode_press) begin
    if(cur_mode == 2)
        cur_mode = 0;
    else cur_mode = cur_mode + 1;
end

always @ (posedge clk) begin
    case (cur_mode)
        0: begin clk_en=1; sw_en=0; al_en=0; end
        1: begin clk_en=0; sw_en=1; al_en=0; end
        2: begin clk_en=0; sw_en=0; al_en=1; end
    endcase
end

// clock
// status: 0 for view, 1 for hour_chk, 2 for init time set
reg [1:0] clk_status = 0;
wire [3:0] ch1,ch2,cm1,cm2,cs1,cs2;
//reg [8:0] clk_disp_en = 8'b00111111;
sec2bcd clock_conv(main_seconds,ch1,ch2,cm1,cm2,cs1,cs2);
wire [16:0] new_time;
bcd2sec clock_set_conv(new_time,kh1,kh2,km1,km2,ks1,ks2);

always @ (posedge set_press) begin
    if(clk_status==2)
        clk_status<=0;
    else
        clk_status<=clk_status+1;
end

always @ (posedge clk) begin
    if(clk_status==2) begin
        keyboard_en = 1;
        clk_init_en = 1;
        clk_init_secs = new_time;
    end else begin
        keyboard_en = 0;
        clk_init_en = 0;
    end
end


// stopwatch
gen_10mhz g2(clk,tenmhz);
reg sw_runstate = 0;
reg [25:0] sw_timerec=0;
wire [16:0] sw_seconds;
output [16:0] seconds;
assign seconds = sw_seconds;
wire [6:0] sw_mms;
assign sw_seconds = sw_timerec / 100;
assign sw_mms = sw_timerec % 100;
wire [3:0] tmp1, tmp2, tmp3, tmp4, tmp5, tmp6;
wire [3:0] swd7,swd6,swd5,swd4,swd3,swd2,swd1,swd0;

bin2dec8 convmm({19'd0,sw_mms},tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,swd1,swd0);
sec2bcd convsec(sw_seconds,swd7,swd6,swd5,swd4,swd3,swd2);

always @(posedge tenmhz) begin
        if(sw_en&&(set_press||rst)) sw_timerec<=0;
        if(sw_runstate==1)
            if(sw_timerec==1_0000_0000)
                        sw_timerec<=0;
                    else
                        sw_timerec<=sw_timerec+1;
end

always @(posedge toggle_press)
    if(sw_en)
        sw_runstate = ~sw_runstate;


// display what?
always @(posedge clk) begin
    if(cur_mode==0) begin
        // clock 
        {d7,d6,d5,d4,d3,d2,d1,d0} = {4'b0,4'b0,ch1,ch2,cm1,cm2,cs1,cs2};
        disp_en = 8'b00111111;
    end else if(cur_mode==1) begin
        // stopwatch
        {d7,d6,d5,d4,d3,d2,d1,d0} = {swd7,swd6,swd5,swd4,swd3,swd2,swd1,swd0};
        disp_en = 8'hff;
    end else if(cur_mode==2) begin
        // alarm setting
        {d7,d6,d5,d4,d3,d2,d1,d0} = {4'd0,4'd1,4'd0,4'd1,4'd0,4'd1,4'd0,4'd1};
    end
end



// choose a display
reg [7:0] disp_choose = 8'h00;
always @(posedge clk) begin
    if(keyboard_en==1)
        disp_choose = 8'hff;
    else
        disp_choose = 8'h00;    
end

wire [7:0] seg_en_1, seg_out_1,seg_en_2, seg_out_2;
select_disp u_disp(~disp_choose, u_seg_en, u_seg_out, seg_en_1, seg_out_1);
select_disp k_disp(disp_choose, keyboard_seg_en, keyboard_seg_out, seg_en_2, seg_out_2);

assign seg_en = seg_en_1 | seg_en_2;
assign seg_out = seg_out_1 | seg_out_2;

endmodule
