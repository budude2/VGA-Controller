-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Apr 17 08:36:13 2019
-- Host        : DESKTOP-KBPHQS1 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/xtjac/Google
--               Drive/School/ADLD/VGA/VGA.srcs/sources_1/ip/pixel_clk/pixel_clk_stub.vhdl}
-- Design      : pixel_clk
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pixel_clk is
  Port ( 
    clk_25m : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_100m : in STD_LOGIC
  );

end pixel_clk;

architecture stub of pixel_clk is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_25m,reset,locked,clk_100m";
begin
end;
