`timescale 1ns / 1ps

module music(
	input clk,
	output reg speaker
);

reg [30:0] tone;
always @(posedge clk) tone <= tone+31'd1;

wire [7:0] fullnote;
music_ROM get_fullnote(.clk(clk), .address(tone[29:24]), .note(fullnote));

wire [2:0] octave;
wire [3:0] note;
divide_by12 get_octave_and_note(.numerator(fullnote[5:0]), .quotient(octave), .remainder(note));

reg [8:0] clkdivider;
always @*
case(note)
	 0: clkdivider = 9'd511;//A
	 1: clkdivider = 9'd482;// A#/Bb
	 2: clkdivider = 9'd455;//B
	 3: clkdivider = 9'd430;//C
	 4: clkdivider = 9'd405;// C#/Db
	 5: clkdivider = 9'd383;//D
	 6: clkdivider = 9'd361;// D#/Eb
	 7: clkdivider = 9'd341;//E
	 8: clkdivider = 9'd322;//F
	 9: clkdivider = 9'd303;// F#/Gb
	10: clkdivider = 9'd286;//G
	11: clkdivider = 9'd270;// G#/Ab
	default: clkdivider = 9'd0;
endcase

reg [8:0] counter_note;
reg [7:0] counter_octave;
always @(posedge clk) counter_note <= counter_note==0 ? clkdivider : counter_note-9'd1;
always @(posedge clk) if(counter_note==0) counter_octave <= counter_octave==0 ? 8'd255 >> octave : counter_octave-8'd1;
always @(posedge clk) if(counter_note==0 && counter_octave==0 && fullnote!=0 && tone[21:18]!=0) speaker <= ~speaker;
endmodule


/////////////////////////////////////////////////////
module divide_by12(
	input [5:0] numerator,  // value to be divided by 12
	output reg [2:0] quotient, 
	output [3:0] remainder
);

reg [1:0] remainder3to2;
always @(numerator[5:2])
case(numerator[5:2])
	 0: begin quotient=0; remainder3to2=0; end
	 1: begin quotient=0; remainder3to2=1; end
	 2: begin quotient=0; remainder3to2=2; end
	 3: begin quotient=1; remainder3to2=0; end
	 4: begin quotient=1; remainder3to2=1; end
	 5: begin quotient=1; remainder3to2=2; end
	 6: begin quotient=2; remainder3to2=0; end
	 7: begin quotient=2; remainder3to2=1; end
	 8: begin quotient=2; remainder3to2=2; end
	 9: begin quotient=3; remainder3to2=0; end
	10: begin quotient=3; remainder3to2=1; end
	11: begin quotient=3; remainder3to2=2; end
	12: begin quotient=4; remainder3to2=0; end
	13: begin quotient=4; remainder3to2=1; end
	14: begin quotient=4; remainder3to2=2; end
	15: begin quotient=5; remainder3to2=0; end
endcase

assign remainder[1:0] = numerator[1:0];  // the first 2 bits are copied through
assign remainder[3:2] = remainder3to2;  // and the last 2 bits come from the case statement
endmodule
/////////////////////////////////////////////////////


module music_ROM(
	input clk,
	input [5:0] address,
	output reg [7:0] note
);

always @(posedge clk)
case(address)
0: note<= 8'd26;
1: note<= 8'd26;
2: note<= 8'd30;
3: note<= 8'd30;
4: note<= 8'd31;
5: note<= 8'd31;
6: note<= 8'd30;
7: note<= 8'd29;
8: note<= 8'd29;
9: note<= 8'd28;
10: note<= 8'd28;
11: note<= 8'd27;
12: note<= 8'd27;
13: note<= 8'd26;
14: note<= 8'd30;
15: note<= 8'd30;
16: note<= 8'd29;
17: note<= 8'd29;
18: note<= 8'd28;
19: note<= 8'd28;
20: note<= 8'd27;
21: note<= 8'd30;
22: note<= 8'd30;
23: note<= 8'd29;
24: note<= 8'd29;
25: note<= 8'd28;
26: note<= 8'd28;
27: note<= 8'd27;
28: note<= 8'd26;
29: note<= 8'd26;
30: note<= 8'd30;
31: note<= 8'd30;
32: note<= 8'd31;
33: note<= 8'd31;
34: note<= 8'd30;
35: note<= 8'd29;
36: note<= 8'd29;
37: note<= 8'd28;
38: note<= 8'd28;
39: note<= 8'd27;
40: note<= 8'd27;
41: note<= 8'd26;
	default: note <= 8'd0;
endcase
endmodule

/////////////////////////////////////////////////////
