//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Mon Apr 29 17:41:22 2019
//Host        : DESKTOP-S0CCCTL running 64-bit major release  (build 9200)
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
    clk_100MHz,
    locked,
    rst);
  input [31:0]bram_addr;
  input bram_clk;
  output [31:0]bram_dout;
  input bram_en;
  input bram_rst;
  input clk_100MHz;
  input locked;
  input rst;

  wire [31:0]bram_addr;
  wire bram_clk;
  wire [31:0]bram_dout;
  wire bram_en;
  wire bram_rst;
  wire clk_100MHz;
  wire locked;
  wire rst;

  microblaze microblaze_i
       (.bram_addr(bram_addr),
        .bram_clk(bram_clk),
        .bram_dout(bram_dout),
        .bram_en(bram_en),
        .bram_rst(bram_rst),
        .clk_100MHz(clk_100MHz),
        .locked(locked),
        .rst(rst));
endmodule
