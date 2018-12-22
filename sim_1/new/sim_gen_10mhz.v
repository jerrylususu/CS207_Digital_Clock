`timescale 1ns / 1ps

module sim_gen_10mhz();

reg clk;
wire out;

gen_10mhz u(clk,out);

initial begin
clk=0;
forever #1 clk=~clk;
end;

endmodule
