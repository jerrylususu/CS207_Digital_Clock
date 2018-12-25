`timescale 1ns / 1ps

// the main entry point

module main(clk,rst,
mode_btn,set_btn,toggle_btn,change_btn,
row,col,
seg_en,seg_out,
speaker,
alarm_light,
clk_en,sw_en, al_en, cd_en,
keyboard_en,
alr_cur_set,
alr_music_dbg,
digit_dbg);

input clk,rst,mode_btn,set_btn,toggle_btn,change_btn;
output [7:0] seg_en, seg_out;
input [3:0] row; output [3:0] col;
output speaker;
output reg alarm_light;
output reg clk_en, sw_en, al_en, cd_en;
output [7:0] alr_music_dbg;
output [3:0] digit_dbg;
reg [1:0] cur_mode = 0;

wire onehz, tenmhz;

wire [16:0] main_seconds;

reg [16:0] clk_init_secs=0;
reg clk_init_en=0;

// core clock
gene_1hz g1(clk,rst,onehz);
time_goes_with_init sec_cnt(clk_init_secs,clk_init_en,main_seconds,onehz,rst);

// take care the buttons
wire mode_press;
button_jitter bj_mode(clk,mode_btn,mode_press);
wire toggle_press;
button_jitter bj_toggle(clk,toggle_btn,toggle_press);
wire set_press;
button_jitter bj_set(clk,set_btn,set_press);
wire change_press;
button_jitter bj_change(clk,change_btn,change_press);

reg [7:0] disp_en;
reg [3:0] d7,d6,d5,d4,d3,d2,d1,d0;
wire [7:0] u_seg_en, u_seg_out; // u for usual
reg [7:0] disp_en_p = 8'b01010100;
display disp(clk,d7,d6,d5,d4,d3,d2,d1,d0,disp_en,disp_en_p,u_seg_en,u_seg_out);





// read from keyboard
output reg keyboard_en = 0;
reg keyboard_mode = 1; // 0->4, 6->1
wire [7:0] keyboard_seg_en, keyboard_seg_out;
wire [3:0] kh1,kh2,km1,km2,ks1,ks2;
reg kb_rst=1;
Display_from_keyboard_inputs keyin(clk,kb_rst,keyboard_en,
row,keyboard_mode,col,
keyboard_seg_en,keyboard_seg_out,
kh1,kh2,km1,km2,ks1,ks2);

// main state machine
always @ (posedge mode_press) begin
    if(cur_mode == 3)
        cur_mode = 0;
    else cur_mode = cur_mode + 1;
end

always @ (posedge clk) begin
    case (cur_mode)
        0: begin clk_en=1; sw_en=0; al_en=0; cd_en=0; end
        1: begin clk_en=0; sw_en=1; al_en=0; cd_en=0; end
        2: begin clk_en=0; sw_en=0; al_en=1; cd_en=0; end
        3: begin clk_en=0; sw_en=0; al_en=0; cd_en=1; end
    endcase
end

// clock
// status: 0 for view, 1 for init time set, 2 for hour_check
reg [1:0] clk_status = 0;
reg hour_check_en = 0;
wire [4:0] hour_chk_en_show;
assign hour_chk_en_show = {3'b0,hour_check_en};
wire [3:0] ch1,ch2,cm1,cm2,cs1,cs2;
//reg [8:0] clk_disp_en = 8'b00111111;
sec2bcd clock_conv(main_seconds,ch1,ch2,cm1,cm2,cs1,cs2);
wire [16:0] new_time;
bcd2sec clock_set_conv(new_time,kh1,kh2,km1,km2,ks1,ks2);
wire hour_chk_spk;
hour_check hour_chk(clk,hour_check_en,main_seconds,hour_chk_spk);

// clock setting state machine
always @ (posedge set_press) begin
    if(clk_status==2)
        clk_status<=0;
    else
        clk_status<=clk_status+1;
end

// clock init time set
//always @ (posedge clk) begin
//    if(cur_mode==0&&clk_status==1) begin
//        keyboard_en = 1;
//        keyboard_mode = 1;
//        clk_init_en = 1;
//        clk_init_secs = new_time;
//    end else begin
//        keyboard_en = 0;
//        clk_init_en = 0;
//    end
//end

// clock hour check set
always @(posedge change_press) begin
    if(cur_mode==0&&clk_status==2)
        hour_check_en = ~hour_check_en;
end


// stopwatch
gen_10mhz g2(clk,tenmhz);
reg sw_runstate = 0;
reg [25:0] sw_timerec=0;
wire [16:0] sw_seconds;
wire [16:0] seconds;
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
            if(sw_timerec==86400_00)
                        sw_timerec<=0;
                    else
                        sw_timerec<=sw_timerec+1;
end

always @(posedge toggle_press)
    if(sw_en)
        sw_runstate = ~sw_runstate;

// alarm
// only 4 alarm
// alarm storage
reg [3:0] alr_en;
reg [1:0] alr_music [0:3];
reg [1:0] alr_len [0:3];
reg [16:0] alr_sec [0:3];
wire buzzer0,buzzer1,buzzer2,buzzer3;

alarm_len_conved a1(alr_en[0],onehz,main_seconds,alr_sec[0],alr_len[0],toggle_press,buzzer0);
alarm_len_conved a2(alr_en[1],onehz,main_seconds,alr_sec[1],alr_len[1],toggle_press,buzzer1);
alarm_len_conved a3(alr_en[2],onehz,main_seconds,alr_sec[2],alr_len[2],toggle_press,buzzer2);
alarm_len_conved a4(alr_en[3],onehz,main_seconds,alr_sec[3],alr_len[3],toggle_press,buzzer3);

wire alarm_spk;
wire alarm_buz0,alarm_buz1,alarm_buz2,alarm_buz3;

songplayer sp1(alarm_buz0,clk,buzzer0,alr_music[0]);
songplayer sp2(alarm_buz1,clk,buzzer1,alr_music[1]);
songplayer sp3(alarm_buz2,clk,buzzer2,alr_music[2]);
songplayer sp4(alarm_buz3,clk,buzzer3,alr_music[3]);

assign alarm_spk = alarm_buz0|alarm_buz1|alarm_buz2|alarm_buz3;
assign alr_music_dbg = {alr_music[0],alr_music[1],alr_music[2],alr_music[3]};

output reg [1:0] alr_cur_set=0; // the alarm setting now
reg [1:0] alr_cur_set_mode=0; // the mode of set

wire [3:0] alr_cur_num_disp = {2'b00,alr_cur_set};

// cycle between set mode
always @(posedge set_press)
    if(cur_mode==2)
        if(alr_cur_set_mode==3)
            alr_cur_set_mode = 0;
        else
            alr_cur_set_mode = alr_cur_set_mode + 1;



// cycle between alarm number
always @(posedge change_press)
    if(cur_mode==2 && alr_cur_set_mode==0)
        if(alr_cur_set==3)
            alr_cur_set = 0;
        else
            alr_cur_set = alr_cur_set + 1;

// set alarm enable
always @(posedge toggle_press)
    if(cur_mode==2&&alr_cur_set_mode==0)
        alr_en[alr_cur_set] = ~alr_en[alr_cur_set];

// show alarm enable
//assign alarm_light = alr_en[alr_cur_set];
always @(posedge clk)
    if(cur_mode==2)
        alarm_light = alr_en[alr_cur_set];
    else
        alarm_light = 0;

//reg [1:0] alr_music_disp;

//output [16:0] seconds;
//assign seconds = alr_music[alr_cur_set];
// cycle between alram music

wire [3:0] alr_music_num_disp = {2'b00,alr_music[alr_cur_set]};

always @(posedge change_press)
    if(cur_mode==2 && alr_cur_set_mode==1) begin
        case(alr_music[alr_cur_set])
            0: alr_music[alr_cur_set] = 1;
            1: alr_music[alr_cur_set] = 2;
            2: alr_music[alr_cur_set] = 0;
        endcase
    end



reg [1:0] alr_len_disp=0;
reg [5:0] alr_len_disp_dec=0;
wire [3:0] alr_len_disp_full1,alr_len_disp_full2;

// convert alarm len to full length;
always @(posedge clk) begin
    case(alr_len[alr_cur_set])
        0: alr_len_disp_dec = 15;
        1: alr_len_disp_dec = 30;
        2: alr_len_disp_dec = 45;
        3: alr_len_disp_dec = 60;
    endcase
end
wire tmpn1,tmpn2,tmpn3,tmpn4,tmpn5,tmpn6;
bin2dec8 alr_len_disp_conv({20'b0,alr_len_disp_dec},tmpn1,tmpn2,tmpn3,tmpn4,tmpn5,tmpn6,alr_len_disp_full1,alr_len_disp_full2);

// cycle between alarm length
always @(posedge change_press)
    if(cur_mode==2 && alr_cur_set_mode==2) begin
//        alr_len_disp = alr_len[alr_cur_set];
        case(alr_len[alr_cur_set])
            0: alr_len[alr_cur_set] = 1;
            1: alr_len[alr_cur_set] = 2;
            2: alr_len[alr_cur_set] = 3;
            3: alr_len[alr_cur_set] = 0;
        endcase
//        alr_len_disp = alr_len[alr_cur_set];
    end
    
// show alarm time
wire [3:0] alr_time_disp1, alr_time_disp2,alr_time_disp3,alr_time_disp4;
wire tmpq1,tmpq2;
sec2bcd alr_time_conv(alr_sec[alr_cur_set],alr_time_disp1, alr_time_disp2,alr_time_disp3,alr_time_disp4,tmpq1,tmpq2);

wire [16:0] alr_newtime;
bcd2sec alr_conv_newtime(alr_newtime,km1,km2,ks1,ks2,4'b0,4'b0);

// cycle to set alarm sec
//always @(posedge change_press)
//    if(cur_mode==2) 
//        if(alr_cur_set_mode==3)
//    begin
//        keyboard_mode = 0;
//        keyboard_en = 1;
//        alr_sec[alr_cur_set] = alr_newtime;
//    end
//    else begin
//        keyboard_en = 0;
//    end

// countdown
wire cd_toggle = toggle_press & (cur_mode==3);
wire cd_clear = change_press & (cur_mode==3);
wire [16:0] cd_seconds;
wire cd_buzzer;

wire [16:0] cd_init_sec;
reg cd_init_en=0;

reg cd_mode=0; // countdown mode, 0->view, 1->settting

bcd2sec cd_set_conv(cd_init_sec,kh1,kh2,km1,km2,ks1,ks2);

always @(posedge set_press)
    if(cur_mode ==3)
        cd_mode = ~cd_mode;
                
wire [3:0] cd1,cd2,cd3,cd4,cd5,cd6;
sec2bcd cd_disp_conv(cd_seconds,cd1,cd2,cd3,cd4,cd5,cd6);

wire cd_buz_freq;
gen_freq #(65536) cd_buz_gen(clk, cd_buz_freq);

wire cd_buz_out;
assign cd_buz_out = cd_buz_freq & cd_buzzer;

reg cd_run=0;

always @(posedge toggle_press)
    if(cur_mode==3) begin
        cd_run = ~cd_run;
    end

wire cd_state;
wire [27:0] cd_seccnt;

countdown cd(clk,rst,onehz,cd_toggle,cd_clear,cd_init_en,cd_run,~cd_run,cd_init_sec,cd_seconds,cd_buzzer,cd_state,cd_seccnt);


// display content
always @(posedge clk) begin
    if(cur_mode==0) begin
        // clock 
        if(clk_status==0) begin
            {d7,d6,d5,d4,d3,d2,d1,d0} = {hour_chk_en_show,4'b0,ch1,ch2,cm1,cm2,cs1,cs2};
            disp_en = 8'b10111111;
        end else if (clk_status==1) begin 
            {d7,d6,d5,d4,d3,d2,d1,d0} = {{3'b0,hour_check_en},4'b0,ch1,ch2,cm1,cm2,cs1,cs2};
            disp_en = 8'b10111111;
        end else begin
            {d7,d6,d5,d4,d3,d2,d1,d0} = {hour_chk_en_show,4'b0,ch1,ch2,cm1,cm2,cs1,cs2};
            if(onehz)
                disp_en = 8'b00111111;
            else
                disp_en = 8'b10111111;
        end
    end else if(cur_mode==1) begin
        // stopwatch
        {d7,d6,d5,d4,d3,d2,d1,d0} = {swd7,swd6,swd5,swd4,swd3,swd2,swd1,swd0};
        disp_en = 8'hff;
    end else if(cur_mode==2) begin
        // alarm
        {d7,d6,d5,d4,d3,d2,d1,d0} = {alr_cur_num_disp,alr_music_num_disp,alr_len_disp_full1,alr_len_disp_full2,
                    alr_time_disp1, alr_time_disp2,alr_time_disp3,alr_time_disp4};
        if(!onehz) begin
            disp_en=8'b11111111;
        end else begin
            // blink alarm setting
            case (alr_cur_set_mode)
                0: disp_en=8'b01111111;
                1: disp_en=8'b10111111;
                2: disp_en=8'b11001111;
                3: disp_en=8'b11110000;
            endcase
        end
    end else if (cur_mode==3) begin
        // countdown
        {d7,d6,d5,d4,d3,d2,d1,d0} = {4'b0,4'b0,cd1,cd2,cd3,cd4,cd5,cd6};
        disp_en = 8'b00111111;
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

// combine the speaker
assign speaker = hour_chk_spk | alarm_spk | cd_buz_out;
assign digit_dbg = {u_seg_out[7],u_seg_out[6],u_seg_out[5],u_seg_out[4]};


// combine the keyboard
always @(posedge clk) begin
    if(cur_mode==0&&clk_status==1) begin
        kb_rst = 1;
        keyboard_en = 1;
        keyboard_mode = 1;
        clk_init_en = 1;
        clk_init_secs = new_time;
        cd_init_en = 0;
    end else if (cur_mode==2&&alr_cur_set_mode==3) begin
        kb_rst = 1;
        keyboard_en = 1;
        keyboard_mode = 0;
        alr_sec[alr_cur_set] = alr_newtime;
        clk_init_en = 0;
        cd_init_en = 0;
    end else if (cur_mode==3&&cd_mode==1) begin
        kb_rst = 1;
        keyboard_en = 1;
        keyboard_mode = 1;
        clk_init_en = 0;
        cd_init_en = 1;
    end else begin
        kb_rst = 0;
        keyboard_en = 0;
        clk_init_en = 0;
        cd_init_en = 0;
    end
end


endmodule
