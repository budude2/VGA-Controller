//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Fri May 10 22:08:37 2019
//Host        : DESKTOP-KBPHQS1 running 64-bit major release  (build 9200)
//Command     : generate_target microblaze_wrapper.bd
//Design      : microblaze_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module microblaze_wrapper
   (bram_addr,
    bram_clk,
    bram_dout,
    bram_en,
    bram_rst,
    clk_123m,
    locked,
    rst);
  input [31:0]bram_addr;
  input bram_clk;
  output [31:0]bram_dout;
  input bram_en;
  input bram_rst;
  input clk_123m;
  input locked;
  input rst;

  wire [31:0]bram_addr;
  wire bram_clk;
  wire [31:0]bram_dout;
  wire bram_en;
  wire bram_rst;
  wire clk_123m;
  wire locked;
  wire rst;

  microblaze microblaze_i
       (.bram_addr(bram_addr),
        .bram_clk(bram_clk),
        .bram_dout(bram_dout),
        .bram_en(bram_en),
        .bram_rst(bram_rst),
        .clk_123m(clk_123m),
        .locked(locked),
        .rst(rst));
endmodule
