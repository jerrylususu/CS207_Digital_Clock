`timescale 1ns / 1ps
module Display_from_keyboard_inputs(
    input clk, rst, en,
    input [3:0] row,
    input mode, //  4 -> 0, 6 -> 1
    output [3:0] col,
    output reg [7:0] seg_en, seg_out,   //  display on light_seg_7
    output [3:0] H, h, M, m, S, s   //  outputs of what we get
    );
    
    //  store inputs from keyboard
    wire [2:0] cursor;  //  to define which digit is being modified (DP lights up)
    wire [3:0] H1, H0, M1, M0, S1, S0;
    Keyboard_input_6x4
        ki64(clk, rst, en,
            row, col,
                H1, H0, M1, M0, S1, S0,
                    cursor);

    assign H = H1; assign h = H0;
    assign M = M1; assign m = M0;
    assign S = S1; assign s = S0;
    
    //  modify a clock for display
    reg [15:0] count = 0;   //  2^16 = 65_536 > 49_999
    reg change = 0;
    always @(posedge clk)
    begin
        if (count == 49_999)
            begin
                count <= 0;
                change <= ~change;
            end
        else
            count <= count + 1;
    end
    
    //  water flow light flash
    reg [2:0] current_digit = 0;
    always @(posedge change)
    begin
        if (mode)   //  6
            if (current_digit == 3'd5)
                current_digit <= 0;
            else
                current_digit <= current_digit + 1;
        else    //  4
            if (current_digit == 3'd3)
                current_digit <= 0;
            else
                current_digit <= current_digit + 1;
    end
    
    //  flash on digit: normally 0.5s period --> 2Hz ==> 1e8/2/2-1 = 25e6-1 = 24_999_999 => 2^25
    reg clk_flash = 0;
    reg [24:0] cnt_flash = 0;
    always @(posedge clk)
    begin
        if (cnt_flash == 25'd24_999_999)
        begin
            cnt_flash <= 0;
            clk_flash <= ~clk_flash;
        end
        else
            cnt_flash <= cnt_flash + 1;
    end
    
    //  light_seg_7 translate
    reg [3:0] keyVal = 4'd0;
    always @(change)
        case (keyVal)
            4'h0: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1100_0000;  //  0
            4'h1: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1111_1001;  //  1
            4'h2: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1010_0100;  //  2
            4'h3: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1011_0000;  //  3
            4'h4: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1001_1001;  //  4
            4'h5: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1001_0010;  //  5
            4'h6: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1000_0010;  //  6
            4'h7: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1111_1000;  //  7
            4'h8: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1000_0000;  //  8
            4'h9: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b1001_1000;  //  9
//            4'hA: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == 8) && (~clk_flash)) ? 8'b1111_1111 : 8'b1000_1000;  //  A: currently useless
//            4'hB: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == 8) && (~clk_flash)) ? 8'b1111_1111 : 8'b1000_0011;  //  b: currently useless
//            4'hC: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == 8) && (~clk_flash)) ? 8'b1111_1111 : 8'b1010_0111;  //  c: clear(rst)?
//            4'hD: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == 8) && (~clk_flash)) ? 8'b1111_1111 : 8'b1010_0001;  //  d: currently useless
//            4'hE: seg_out <= 8'b1000_0110;  //  E(*): cursor moves left
//            4'hF: seg_out <= 8'b1000_1110;  //  F(#): cursor moves right
            default: seg_out <= (en && (current_digit - 1 == cursor || current_digit + 1 == (mode ? 7 : 5)) && (~clk_flash)) ? 8'b1111_1111 : 8'b0000_0000;    //  all light up including DP
        endcase
    
    //  identify val now    
    always @(posedge change)
    begin
        case (current_digit)
            4'd0: begin seg_en <= 8'b1111_1110; keyVal <= S0; end
            4'd1: begin seg_en <= 8'b1111_1101; keyVal <= S1; end
            4'd2: begin seg_en <= 8'b1111_1011; keyVal <= M0; end
            4'd3: begin seg_en <= 8'b1111_0111; keyVal <= M1; end
            4'd4: begin seg_en <= 8'b1110_1111; keyVal <= H0; end
            4'd5: begin seg_en <= 8'b1101_1111; keyVal <= H1; end
            //  two useless tubes
//            4'd6: begin seg_en <= 8'b1111_1111; end
//            4'd7: begin seg_en <= 8'b0111_1111; end
        endcase
    end
    
endmodule