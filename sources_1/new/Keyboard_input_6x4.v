`timescale 1ns / 1ps
module Keyboard_input_6x4(
    input clk, rst, //  rst is a control input for the whole system
    input en,   //  enable signal --> 1 active
    input [3:0] row,    //  keyboard rows input
    output [3:0] col,   //  keyboard columns output
    output [3:0] H1, H0, M1, M0, S1, S0, //  Hours, Minutes, Seconds -> 14:20:59
    output reg [2:0] cursor = 3'd0 //  cursor indicating the digit currently being modified
    );
    //  Build a memory with six 4-bit memory units
    reg [3:0] Memory [5:0];
    assign {H1, H0, M1, M0, S1, S0} =
        {Memory[5], Memory[4],
            Memory[3], Memory[2],
                Memory[1], Memory[0]};
    
    //  generate clk pulses for scan
    wire key_clk;
    scan_key_clk skc(clk, rst, key_clk);
    
    //  scan and pinpoint the coordinate of the key
    wire key_pressed_flag;
    wire [3:0] col_val, row_val;
    key_coordinate kc(clk, key_clk, rst, row, col, key_pressed_flag, col_val, row_val);
 
    wire reset;  //  reset the values using keyboard (regional reset)
    reg rst_kb = 1;
    assign reset = rst_kb & rst;
    
    // translate value of key
    reg [3:0] keyVal = 4'd0;
    reg rst_kb_flip = 0;
    reg rst_kb_flip_pre = 0;
    reg activate = 0;
    always @(posedge key_clk)
    begin
        if (key_pressed_flag)
            activate <= 1;
        else
            activate <= 0;
    end
    always @(posedge activate, negedge reset)
    begin
        if (~reset)
        begin
            keyVal <= 4'd0;
        end
        else
            if (key_pressed_flag && activate && en)
            begin
                    case ({col_val, row_val})
                    //  row 0
                    8'b1110_1110: keyVal <= 4'd1;
                    8'b1101_1110: keyVal <= 4'd2;
                    8'b1011_1110: keyVal <= 4'd3;
                    8'b0111_1110: keyVal <= 4'h9;   //  A: invalid
                    //  row 1
                    8'b1110_1101: keyVal <= 4'd4;
                    8'b1101_1101: keyVal <= 4'd5;
                    8'b1011_1101: keyVal <= 4'd6;
                    8'b0111_1101: keyVal <= 4'h9;   //  B: invalid
                    //  row 2
                    8'b1110_1011: keyVal <= 4'd7;
                    8'b1101_1011: keyVal <= 4'd8;
                    8'b1011_1011: keyVal <= 4'd9;
                    8'b0111_1011:   //  C: clear op for rst?
                    begin
                        rst_kb_flip <= ~rst_kb_flip;
                    end
                    //  row 3
                    8'b1110_0111:   //  *: cursor moves left
                    begin
                        if (cursor == 3'd5)
                        begin
                            cursor = 3'd0;
                            keyVal = Memory[0];
                        end
                        else
                        begin
                            case (cursor)
                            3'd0:   keyVal = Memory[1];
                            3'd1:   keyVal = Memory[2];
                            3'd2:   keyVal = Memory[3];
                            3'd3:   keyVal = Memory[4];
                            3'd4:   keyVal = Memory[5];
                            endcase
                            cursor = cursor + 1;
                        end
                    end
                    8'b1101_0111: keyVal <= 3'd0;
                    8'b1011_0111:   //  #: cursor moves right
                    begin
                        if (cursor == 3'd0)
                        begin
                            cursor = 3'd5;
                            keyVal = Memory[5];
                        end
                        else
                        begin
                            case (cursor)
                            3'd1:   keyVal = Memory[0];
                            3'd2:   keyVal = Memory[1];
                            3'd3:   keyVal = Memory[2];
                            3'd4:   keyVal = Memory[3];
                            3'd5:   keyVal = Memory[4];
                            endcase
                            cursor = cursor - 1;
                        end
                    end
                    8'b0111_0111: keyVal <= 4'h9;   //  D: invalid   
                    endcase
            end
    end    
    
    //  define storage place
    always @(posedge key_clk, negedge reset)
    begin
        if (~reset)
        begin
            Memory[0] <= 4'd0;  Memory[1] <= 4'd0;
            Memory[2] <= 4'd0;  Memory[3] <= 4'd0;
            Memory[4] <= 4'd0;  Memory[5] <= 4'd0;
        end
        else
           if (en)
              case (cursor)  //  default: no assignment
                 3'd0: Memory[0] <= keyVal;  //  H1
                 3'd1: Memory[1] <= keyVal;  //  H0
                 3'd2: Memory[2] <= keyVal;  //  M1
                 3'd3: Memory[3] <= keyVal;  //  M0
                 3'd4: Memory[4] <= keyVal;  //  S1
                 3'd5: Memory[5] <= keyVal;  //  S0
              endcase
    end
    
    //  modify rst_kb with rst_kb_flip_pre and rst_kb_pre
    reg [19:0] cnt_rst = 0;
    always @(posedge clk)
    begin
        if (~rst_kb_flip_pre)   //  1'b0
        begin
            case (rst_kb_flip)
                1'b0:   //  same
                begin
                    cnt_rst <= 0;
                    rst_kb <= 1;
                end
                1'b1:   //  change
                begin
                    if (cnt_rst == 20'd999_999) //  20ms
                    begin
                        cnt_rst <= 0;
                        rst_kb <= 1;
                        rst_kb_flip_pre <= ~rst_kb_flip_pre;    //  jump to state 1'b1
                    end
                    else    //  cnt_rst < 20'd999_999
                    begin
                        cnt_rst <= cnt_rst + 1;
                        rst_kb <= 0;
                    end
                end
            endcase
        end
        else    //  1'b1
        begin
            case (rst_kb_flip)
                1'b0:
                begin
                    if (cnt_rst == 20'd999_999) //  20ms
                    begin
                        cnt_rst <= 0;
                        rst_kb <= 1;
                        rst_kb_flip_pre <= ~rst_kb_flip_pre;    //  jump to state 1'b0
                    end
                    else // cnt_rst < 20'd999_999
                    begin
                        cnt_rst <= cnt_rst + 1;
                        rst_kb <= 0;
                    end
                end
                1'b1:   //  same
                begin
                    cnt_rst <= 0;
                    rst_kb <= 1;
                end
            endcase
        end
    end

endmodule