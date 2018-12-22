`timescale 1ns / 1ps

module sim_jitter();

reg clk,btn;
wire btn_out;

button_jitter u(clk,btn,btn_out);

initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin
btn = 0;
#3 btn = 1;
#50 btn = 0;
#50 btn = 1;
#3 btn = 0;
#10 btn = 1;
#20 btn = 0;
#5 $finish;
end


endmodule
