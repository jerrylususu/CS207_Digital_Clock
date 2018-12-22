`timescale 1ns / 1ps

// this module tries to elimiate the jitter in button pressing
// use 20ms as a counter

module button_jitter(clk, but_in, but_out);

input clk, but_in;
output but_out;

reg [1:0] record=2'b00;
wire change_detect;
reg [16:0] cnt;
reg out;

always @(posedge clk)
    record <= {record[0],but_in};

assign change_detect = record[0]^record[1];

always @(posedge clk)
    if(change_detect==1)
        cnt <= 0;
    else
        cnt <= cnt+1;
        
always @(posedge clk)
    if(cnt==10_0000)
//        if(cnt==5)
        begin
        out <= record[0];
//        cnt <= 0;
        end
assign but_out = out;

endmodule
