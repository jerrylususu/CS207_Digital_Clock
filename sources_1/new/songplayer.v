`timescale 1ns / 1ps

module songplayer ( audio , sys_CLK , button, song_id);

output    audio;
input     sys_CLK;
input     button;
input [1:0] song_id;

reg  [23:0] counter4Hz,
            counter6MHz;
reg  [13:0]  count,origin;
reg  audiof;

reg  clk_6MHz,
     clk_4Hz;

reg  [4:0]  j;
reg  [7:0]  len;


assign audio= button? audiof : 1'b0 ;  //控制开关

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
    default:origin='d016383; // try to modify
    endcase             
end

always @(posedge clk_4Hz)  //乐谱
begin

if(song_id==0) begin
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
end else if (song_id==1) begin
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
end else if (song_id==2) begin // updated at 12/26 00:51
     if(len==63)
   len=0;
else
   len=len+1;
case(len)

0:j=3;
1:j=3;
2:j=1;
3:j=1;
4:j=8;
5:j=8;
6:j=1;
7:j=1;
8:j=5;
9:j=5;
10:j=11;
11:j=11;
12:j=5;
13:j=5;
14:j=1;
15:j=1;
16:j=11;
17:j=11;
18:j=8;
19:j=8;
20:j=1;
21:j=1;
22:j=8;
23:j=8;
24:j=0;
25:j=0;
26:j=3;
27:j=3;
28:j=1;
29:j=1;
30:j=8;
31:j=8;
32:j=1;
33:j=1;
34:j=5;
35:j=5;
36:j=11;
37:j=11;
38:j=5;
39:j=5;
40:j=1;
41:j=1;
42:j=11;
43:j=11;
44:j=8;
45:j=8;
46:j=1;
47:j=1;
48:j=8;
49:j=8;
50:j=0;
51:j=0;
52:j=0;
53:j=0;
54:j=0;
55:j=0;
56:j=0;
57:j=0;
58:j=0;
59:j=0;
60:j=0;
61:j=0;
62:j=0;
63:j=0;

endcase

end
    
    
                
end
endmodule
