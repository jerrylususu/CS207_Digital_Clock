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
0:j=8;
    1:j=8;
    2:j=9;
    3:j=9;
    4:j=10;
    5:j=10;
    6:j=8;
    7:j=8;
    8:j=8;
    9:j=8;
    10:j=9;
    11:j=9;
    12:j=10;
    13:j=10;
    14:j=8;
    15:j=8;
    16:j=10;
    17:j=10;
    18:j=11;
    19:j=11;
    20:j=12;
    21:j=12;
    22:j=12;
    23:j=12;
    24:j=10;
    25:j=10;
    26:j=11;
    27:j=11;
    28:j=12;
    29:j=12;
    30:j=12;
    31:j=12;
    32:j=12;
    33:j=13;
    34:j=12;
    35:j=11;
    36:j=10;
    37:j=10;
    38:j=8;
    39:j=8;
    40:j=12;
    41:j=13;
    42:j=12;
    43:j=11;
    44:j=10;
    45:j=10;
    46:j=8;
    47:j=8;
    48:j=8;
    49:j=8;
    50:j=12;
    51:j=12;
    52:j=8;
    53:j=8;
    54:j=8;
    55:j=8;
    56:j=8;
    57:j=8;
    58:j=12;
    59:j=12;
    60:j=8;
    61:j=8;
    62:j=8;
    63:j=8;
    default:j=1;
endcase
                
end
endmodule