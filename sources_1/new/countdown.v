`timescale 1ns / 1ps

// this tries to do count down

module countdown(init, init_en, clk,onehz,toggle_press,out);

input [16:0] init;
input init_en, clk;
input onehz;
input toggle_press;
output reg out;

reg [16:0] remain;
reg run_status = 0;
reg sound = 1;
always @(posedge clk) begin
    if(remain==0&&run_status==1)
    


    if(init_en)
        remain <= init;
    else
        if(run_status == 1)
            remain <= remain-1;
        
        
end
endmodule
