`timescale 1ns / 1ps

module sim_gen_25mhz();

reg clk;
wire out;

gen_25mhz u(clk,out);

initial begin
clk=0;
forever #1 clk=~clk;
end;

endmodule
