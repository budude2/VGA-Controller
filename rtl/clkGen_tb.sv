`timescale 1ns / 1ps

module clkGen_tb(

    );

logic clk_100m = 0;
logic reset, clk_25m, locked, hclk, dataValid;

clockGen dut(.*);

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
