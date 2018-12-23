`timescale 1ns / 1ps

module sim_test_rw();

reg clk;
wire [5:0] out,in;
reg en;

rw_test_wrapper u(clk,out,in);

initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin
en = 0;
#6 en = 1;
#10 en = 0;
#60 en = 1;
#100 en = 0;
#10
$finish;
end

endmodule
