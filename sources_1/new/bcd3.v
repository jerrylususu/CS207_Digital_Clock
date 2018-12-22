`timescale 1ns / 1ps


module bcd3(
    input [7:0] binary,
    output reg [3:0] q2,
    output reg [3:0] q1,
    output reg [3:0] q0
    );
    
    integer i;
    always @(binary)
    begin
        {q2,q1,q0}=0;
    
        for(i=7;i>=0;i=i-1)
        begin
            if(q2>=5)
                q2 = q2+3;
            if(q1>=5)
                q1 = q1+3;
            if(q0>=5)
                q0 = q0+3;
                
            q2 = q2<<1;
            q2[0]=q1[3];
            q1 = q1<<1;
            q1[3]=q0[3];
            q0 = q0<<1;
            q0[0]=binary[i];
        end
    
    end
    
endmodule
