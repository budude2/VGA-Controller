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
logic [18:0] addr;

clockGen pixelClkGen(.clk_100m(clk_100m), .reset(reset), .clk_25m(pixelClk), .locked(locked_i));
vgaClk vgaTiming(.pixelClk(pixelClk), .locked(locked_i), .hClk(hclk), .vClk(vclk), .xCor(xCor), .yCor(yCor), .hVis(dValid_h), .vVis(dValid_v));

patternGen rainbow(.dValid(dValid_h & dValid_v), .xCor(xCor), .yCor(yCor), .R(redVal), .G(greenVal), .B(blueVal));

assign addr = xCor + 640 * yCor;

assign VGA_R = redVal;
assign VGA_G = greenVal;
assign VGA_B = blueVal;

assign locked = locked_i;

endmodule