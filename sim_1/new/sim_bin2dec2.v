`timescale 1ns / 1ps

module sim_bin2dec2();

reg [6:0] bin;
wire [3:0] q7,q6,q5,q4,q3,q2,q1,q0;

bin2dec8 u({19'd0,bin},q7,q6,q5,q4,q3,q2,q1,q0);

initial begin
bin = 0;
forever #1 bin = bin+1;
end

endmodule
