`timescale 1ns / 1ps

// input: 6* 4bit BCD
// output: seconds in decimal [16:0]

module bcd2sec(seconds,h1,h2,m1,m2,s1,s2);
    input [3:0] h1,h2,m1,m2,s1,s2;
    output [16:0] seconds;
    
    assign seconds=((h1*10+h2)*3600+(m1*10+m2)*60+s1*10+s2)%86400;

endmodule