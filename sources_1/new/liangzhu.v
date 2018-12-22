//--------------------------------------------------------------------------------------------------
//
// Title       : play
// Author      : wangliang
//
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
//
// Description : 
//
//-------------------------------------------------------------------------------------------------
`timescale 1 ns / 1 ps

module liangzhu ( audio , sys_CLK , button);

output    audio;
input     sys_CLK;
input     button;

reg  [23:0] counter4Hz,
            counter6MHz;
reg  [13:0]  count,origin;
reg  audiof;

reg  clk_6MHz,
     clk_4Hz;

reg  [4:0]  j;
reg  [7:0]  len;


assign audio= button? audiof : 1'b1 ;  //控制开关

always @(posedge sys_CLK)              //6MHz分频
begin
    if(counter6MHz==4)
    begin
        counter6MHz=0;
        clk_6MHz=~clk_6MHz;
    end
    else
    begin
        counter6MHz=counter6MHz+1;
    end
end

always @(posedge sys_CLK)                 //4Hz分频
begin
    if(counter4Hz==6250000)              
    begin
        counter4Hz=0;
        clk_4Hz=~clk_4Hz;
    end
    else
    begin
        counter4Hz=counter4Hz+1;
    end
end


always @(posedge clk_6MHz)
begin
    if(count==16383)    
    begin
        count=origin;
        audiof=~audiof;
    end
    else
        count=count+1;
end


always @(posedge clk_4Hz)       
begin
     case(j)
    'd1:origin='d4916;  //low
    'd2:origin='d6168;
    'd3:origin='d7281;
    'd4:origin='d7791;
    'd5:origin='d8730;
    'd6:origin='d9565;
    'd7:origin='d10310;
    'd8:origin='d010647;  //middle
    'd9:origin='d011272;
    'd10:origin='d011831;
    'd11:origin='d012087;
    'd12:origin='d012556;
    'd13:origin='d012974;
    'd14:origin='d013346;
    'd15:origin='d13516;  //high
    'd16:origin='d13829;
    'd17:origin='d14108;
    'd18:origin='d11535;
    'd19:origin='d14470;
    'd20:origin='d14678;
    'd21:origin='d14864;
    default:origin='d011111;
    endcase             
end

always @(posedge clk_4Hz)  //乐谱
begin
     if(len==63)
        len=0;
    else
        len=len+1;
    case(len)
     0:j=3;
     1:j=3;
     2:j=3;
     3:j=3;
     4:j=5;
     5:j=5;
     6:j=5;
     7:j=6;
     8:j=8;
     9:j=8;
     10:j=8;
     11:j=6;
     12:j=6;
     13:j=6;
     14:j=6;
     15:j=12;
     16:j=12;
     17:j=12;
     18:j=15;
     19:j=15;
     20:j=15;
     21:j=15;
     22:j=15;
     23:j=9;
     24:j=9;
     25:j=9;
     26:j=9;
     27:j=9;
     28:j=9;
     29:j=9;
     30:j=9;
     31:j=9;
     32:j=9;
     33:j=9;
     34:j=10;
     35:j=7;
     36:j=7;
     37:j=6;
     38:j=6;
     39:j=5;
     40:j=5;
     41:j=5;
     42:j=6;
     43:j=8;
     44:j=8;
     45:j=9;
     46:j=9;
     47:j=3;
     48:j=3;
     49:j=8;
     50:j=8;
     51:j=8;
     52:j=5;
     53:j=5;
     54:j=8;
     55:j=5;
     56:j=5;
     57:j=5;
     58:j=5;
     59:j=5;
     60:j=5;
     61:j=5;
     62:j=5;
     63:j=5;
endcase
                
end
endmodule