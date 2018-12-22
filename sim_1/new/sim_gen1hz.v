`timescale 1ps / 1ps


module sim_gen1hz();

reg clk;
reg rst;
wire onehz;

wrap_gen_1hz u(clk,rst,onehz);

initial begin
clk = 0;
forever #1 clk = ~clk;
end

endmodule
