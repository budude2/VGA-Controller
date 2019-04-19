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

logic dValid_h, dValid_v;

clockGen clocks(.clk_100m(clk_100m), .reset(reset), .clk_25m(), .locked(locked), .hclk(hclk), .vclk(vclk), .dValid_h(dValid_h), .dValid_v(dValid_v));

assign VGA_R = 4'b1111 & {dValid_v,dValid_v,dValid_v,dValid_v} & {dValid_h,dValid_h,dValid_h,dValid_h};
assign VGA_G = 4'b1111 & {dValid_v,dValid_v,dValid_v,dValid_v} & {dValid_h,dValid_h,dValid_h,dValid_h};
assign VGA_B = 4'b1111 & {dValid_v,dValid_v,dValid_v,dValid_v} & {dValid_h,dValid_h,dValid_h,dValid_h};

endmodule