`timescale 1ns / 1ps

// most 1e8
// from binary to 8*4bit BCD

// credit from https://pubweb.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html

module bin2dec8(bin,q7,q6,q5,q4,q3,q2,q1,q0);

input [25:0] bin;
output reg [3:0] q7,q6,q5,q4,q3,q2,q1,q0;

reg [5:0] i;
// the problem might have something to do with negitive value

always @(*)
begin

    // set initial value
    q7=0;
    q6=0;
    q5=0;
    q4=0;
    q3=0;
    q2=0;
    q1=0;
    q0=0;

    // try to do convert
    for(i=26;i>0;i=i-1)
    begin
        if(q7>=5)
            q7 = q7+3;
        if(q6>=5)
            q6 = q6+3;
        if(q5>=5)
            q5 = q5+3;
        if(q4>=5)
            q4 = q4+3;
        if(q3>=5)
            q3 = q3+3;
        if(q2>=5)
            q2 = q2+3;
        if(q1>=5)
            q1 = q1+3;
        if(q0>=5)
            q0 = q0+3;
            
        q7=q7<<1;
        q7[0]=q6[3];
        q6=q6<<1;
        q6[0]=q5[3];
        q5=q5<<1;
        q5[0]=q4[3];
        q4=q4<<1;
        q4[0]=q3[3];
        q3=q3<<1;
        q3[0]=q2[3];
        q2=q2<<1;
        q2[0]=q1[3];
        q1=q1<<1;
        q1[0]=q0[3];
        q0=q0<<1;
        q0[0]=bin[i-1];            
    end
   
end
endmodule
