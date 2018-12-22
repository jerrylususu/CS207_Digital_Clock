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
0:j=10;
    1:j=10;
    2:j=8;
    3:j=8;
    4:j=12;
    5:j=12;
    6:j=8;
    7:j=8;
    8:j=12;
    9:j=12;
    10:j=13;
    11:j=13;
    12:j=12;
    13:j=12;
    14:j=8;
    15:j=8;
    16:j=13;
    17:j=13;
    18:j=12;
    19:j=12;
    20:j=8;
    21:j=8;
    22:j=12;
    23:j=12;
    24:j=10;
    25:j=10;
    26:j=8;
    27:j=8;
    28:j=12;
    29:j=12;
    30:j=8;
    31:j=8;
    32:j=12;
    33:j=12;
    34:j=13;
    35:j=13;
    36:j=12;
    37:j=12;
    38:j=8;
    39:j=8;
    40:j=13;
    41:j=13;
    42:j=12;
    43:j=12;
    44:j=8;
    45:j=8;
    46:j=12;
    47:j=12;
    48:j=7;
    49:j=7;
    50:j=7;
    51:j=7;
    52:j=7;
    53:j=7;
    54:j=7;
    55:j=7;
    56:j=7;
    57:j=7;
    58:j=7;
    59:j=7;
    60:j=7;
    61:j=7;
    62:j=7;
    63:j=7;
    default:j=1;
endcase
                
end
endmodule