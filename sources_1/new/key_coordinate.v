`timescale 1ns / 1ps
module key_coordinate(
    input clk, key_clk, rst, //  key_clk: scanning clk pulse
    input [3:0] row,    //  keyboard rows
    output reg [3:0] col,   //  keyboard columns
    output reg key_pressed_flag,    //  judge if keyboard is pressed
    output reg [3:0] col_val, row_val   //  column value & row value
    );
    
    // Define some constants
    parameter NO_KEY_PRESSED = 6'b000_001;
    parameter SCAN_COL_0 = 6'b000_010;
    parameter SCAN_COL_1 = 6'b000_100;
    parameter SCAN_COL_2 = 6'b001_000;
    parameter SCAN_COL_3 = 6'b010_000;
    parameter KEY_PRESSED = 6'b100_000;
    
    reg [5:0] current_state, next_state;

    //  basic transitions
    always @(posedge key_clk, negedge rst)
    begin
        if (~rst)
            current_state <= NO_KEY_PRESSED;
        else
            current_state <= next_state;
    end
    
    //  details: triggered by changing of current_state (why "*" ?)
    //  row[i] = 0 --> activated
    always @(*)
    begin
        case (current_state)
            NO_KEY_PRESSED:
                if (row != 4'b1111) //  pressed --> go and start scanning col[0]
                    next_state <= SCAN_COL_0;
                else
                    next_state <= NO_KEY_PRESSED;
                    
            SCAN_COL_0:
                if (row != 4'b1111)
                    next_state <= KEY_PRESSED;
                else
                    next_state <= SCAN_COL_1;
                    
            SCAN_COL_1:
                if (row != 4'b1111)
                    next_state <= KEY_PRESSED;
                else
                    next_state <= SCAN_COL_2;
                    
            SCAN_COL_2:
                if (row != 4'b1111)
                    next_state <= KEY_PRESSED;
                else
                    next_state <= SCAN_COL_3;
                            
            SCAN_COL_3:
                if (row != 4'b1111)
                    next_state <= KEY_PRESSED;
                else
                    next_state <= NO_KEY_PRESSED;
                    
            KEY_PRESSED:
                if (row != 4'b1111) //  still pressed
                    next_state <= KEY_PRESSED;
                else    //  release now
                    next_state <= NO_KEY_PRESSED;
        endcase
    end
    always @(posedge key_clk, negedge rst)
    begin
        if (~rst)
        begin
            col <= 4'b0000; //  why not 1111?
            key_pressed_flag <= 0;
        end
        else
            case (next_state)
                NO_KEY_PRESSED:
                begin
                    col <= 4'b0000; //  why not 1111?
                    key_pressed_flag <= 0;
                end
                
                SCAN_COL_0:
                    col <= 4'b1110;
                    
                SCAN_COL_1:
                    col <= 4'b1101;
                        
                SCAN_COL_2:
                    col <= 4'b1011;
                            
                SCAN_COL_3:
                    col <= 4'b0111;
                    
                KEY_PRESSED:    //  store value and change flag
                begin
                    col_val <= col;
                    row_val <= row;
                    key_pressed_flag <= 1;
                end
            endcase
    end
    
endmodule
