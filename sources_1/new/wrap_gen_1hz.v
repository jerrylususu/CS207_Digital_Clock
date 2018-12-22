`timescale 1ns / 1ps

module wrap_gen_1hz(clk,rst,onehz);
input clk,rst;
output onehz;

gene_1hz u(clk,rst,onehz);

endmodule
