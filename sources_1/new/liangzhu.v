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
0:j=19;
    1:j=18;
    2:j=13;
    3:j=13;
    4:j=14;
    5:j=14;
    6:j=18;
    7:j=17;
    8:j=11;
    9:j=11;
    10:j=12;
    11:j=12;
    12:j=16;
    13:j=15;
    14:j=10;
    15:j=10;
    16:j=12;
    17:j=12;
    18:j=15;
    19:j=15;
    20:j=19;
    21:j=18;
    22:j=13;
    23:j=13;
    24:j=14;
    25:j=14;
    26:j=18;
    27:j=17;
    28:j=11;
    29:j=11;
    30:j=12;
    31:j=12;
    32:j=16;
    33:j=15;
    34:j=10;
    35:j=10;
    36:j=12;
    37:j=12;
    38:j=15;
    39:j=15;
    40:j=19;
    41:j=18;
    42:j=13;
    43:j=13;
    44:j=14;
    45:j=14;
    46:j=18;
    47:j=17;
    48:j=11;
    49:j=11;
    50:j=12;
    51:j=12;
    52:j=16;
    53:j=15;
    54:j=10;
    55:j=10;
    56:j=12;
    57:j=12;
    58:j=15;
    59:j=15;
    60:j=0;
    61:j=0;
    62:j=0;
    63:j=0;
    default:j=1;
endcase
                
end
endmodule