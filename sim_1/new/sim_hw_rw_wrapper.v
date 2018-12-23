`timescale 1ns / 1ps

module sim_hw_rw_wrapper();

reg clk,btn;
wire [1:0] in,out;
wire twotime;

hw_rw_wrapper u(clk,btn,in,out,twotime);


initial begin
btn = 0;
#5 btn = ~btn;
#10 btn = ~btn;
#20 btn = ~btn;
#30 btn = ~btn;
#5 btn = ~btn;
#50 btn = ~btn;
#100 $finish;
end

initial begin
clk = 0;
forever #1 clk = ~clk;
end

endmodule
