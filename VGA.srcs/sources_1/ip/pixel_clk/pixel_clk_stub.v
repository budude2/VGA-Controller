// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri Apr 26 15:13:26 2019
// Host        : DESKTOP-KBPHQS1 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/xtjac/School/VGA-Controller/VGA.srcs/sources_1/ip/pixel_clk/pixel_clk_stub.v
// Design      : pixel_clk
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pixel_clk(clk_25m, clk_100m_o, reset, locked, clk_100m)
/* synthesis syn_black_box black_box_pad_pin="clk_25m,clk_100m_o,reset,locked,clk_100m" */;
  output clk_25m;
  output clk_100m_o;
  input reset;
  output locked;
  input clk_100m;
endmodule
