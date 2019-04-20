`timescale 1ns / 1ps

module VGA(
    input logic clk_100m,
    input logic reset,
    output logic locked,
    output logic hclk,
    output logic vclk,
    output logic [3:0] VGA_R,
    output logic [3:0] VGA_G,
    output logic [3:0] VGA_B
    );

logic dValid_h, dValid_v, pixelClk, locked_i;
logic [3:0] redVal, greenVal, blueVal;
logic [9:0] xCor, yCor;

clockGen clocks(.clk_100m(clk_100m), .reset(reset), .clk_25m(pixelClk), .locked(locked_i), .hclk(hclk), .vclk(vclk), .dValid_h(dValid_h), .dValid_v(dValid_v));

// lfsr red(.clk(pixelClk), .set_seed(~locked_i), .seed(26), .rand_out(redVal));
// lfsr blue(.clk(pixelClk), .set_seed(~locked_i), .seed(256), .rand_out(blueVal));
// lfsr green(.clk(pixelClk), .set_seed(~locked_i), .seed(318), .rand_out(greenVal));

pixelTracker xygen(.pixelClk(pixelClk), .locked(locked_i), .xCor(xCor), .yCor());
patternGen rainbow(.pixelClk(pixelClk), .locked(locked_i), .dValid(dValid_h & dValid_v), .xCor(xCor), .yCor(yCor), .R(redVal), .G(greenVal), .B(blueVal));

assign VGA_R = redVal;
assign VGA_G = greenVal;
assign VGA_B = blueVal;

assign locked = locked_i;

endmodule