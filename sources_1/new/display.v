`timescale 1ns / 1ps

module display(clk,d7,d6,d5,d4,d3,d2,d1,d0,en,en_point,seg_en,seg_out);
input clk;
input [3:0] d0,d1,d2,d3,d4,d5,d6,d7;
input [7:0] en;
input [7:0] en_point;

output reg [7:0] seg_en;
output [7:0] seg_out;

reg [30:0] count=0;
reg change=0;
always @(posedge clk)
begin
    if(count==49999)
        begin
            count <= 0;
            change <= ~change;
        end
    else    
        count <= count +1;
end

reg [2:0] current_digit=0;
always @(posedge change)
begin
    if(current_digit==7)
        current_digit <= 0;
    else
        current_digit <= current_digit + 1;
end

reg [3:0] current_num=0;
num_to_segout u(current_num,current_digit,en_point,seg_out);

always @(posedge change)
begin
    case(current_digit)
        0: if(en[0]) begin seg_en<=8'b1111_1110; current_num<=d0; end else seg_en<=8'b1111_1111;
        1: if(en[1]) begin seg_en<=8'b1111_1101; current_num<=d1; end else seg_en<=8'b1111_1111;  
        2: if(en[2]) begin seg_en<=8'b1111_1011; current_num<=d2; end else seg_en<=8'b1111_1111;  
        3: if(en[3]) begin seg_en<=8'b1111_0111; current_num<=d3; end else seg_en<=8'b1111_1111;  
        4: if(en[4]) begin seg_en<=8'b1110_1111; current_num<=d4; end else seg_en<=8'b1111_1111;  
        5: if(en[5]) begin seg_en<=8'b1101_1111; current_num<=d5; end else seg_en<=8'b1111_1111;  
        6: if(en[6]) begin seg_en<=8'b1011_1111; current_num<=d6; end else seg_en<=8'b1111_1111;  
        7: if(en[7]) begin seg_en<=8'b0111_1111; current_num<=d7; end else seg_en<=8'b1111_1111;  
//        6: begin seg_en=8'b1011_1111; current_num=1; end
//        7: begin seg_en=8'b0111_1111; current_num=2; end
    endcase
end

endmodule
