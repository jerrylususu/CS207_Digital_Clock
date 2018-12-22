`timescale 1ns / 1ps

// bin -> 2 digit dec

module bin2dec2(
    input [6:0] binary,
    output reg [3:0] q1,
    output reg [3:0] q0
    );
    
    reg [1:0] i;
    
    always @(binary)
    begin
        {q1,q0}=0;
    
        for(i=2;i>0;i=i-1)
        begin
            if(q1>=5)
                q1 = q1+3;
            if(q0>=5)
                q0 = q0+3;
                
            q1 = q1<<1;
            q1[0]=q0[3];
            q0 = q0<<1;
            q0[0]=binary[i-1];
        end
    
    end
    
endmodule