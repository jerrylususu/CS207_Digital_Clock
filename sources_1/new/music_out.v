`timescale 1ns / 1ps

// attempts to get the right frequency

module music_out(
	input clk,
	output speaker
);

wire fourx;
gen_25mhz gen(clk,fourx);
music mus(fourx,speaker);

endmodule