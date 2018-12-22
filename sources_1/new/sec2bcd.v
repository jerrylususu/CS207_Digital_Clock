`timescale 1ns / 1ps

// input: seconds in decimal [16:0]
// output: 6* 4bit BCD

module sec2bcd(seconds,h1,h2,m1,m2,s1,s2);
    input [16:0] seconds;
    output [3:0] h1,h2,m1,m2,s1,s2;
    wire[31:0] s=seconds%60;
    wire[31:0] m=(seconds/60)%60;
    wire[31:0] h=(seconds/3600)%24;
    assign h1=h/10;
    assign h2=h%10;
    assign m1=m/10;
    assign m2=m%10;
    assign s1=s/10;
    assign s2=s%10;
endmodule
