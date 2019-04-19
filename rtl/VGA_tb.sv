`timescale 1ns / 1ps

module VGA_tb(

    );


logic clk_100m = 0;
logic reset, locked, hclk, vclk;

logic [3:0] VGA_R, VGA_B, VGA_G;

VGA dut(.*);

always begin
    #5
    clk_100m = ~clk_100m;
end

initial begin
    reset = 1;
    #20
    reset = 0;
end

endmodule
