`timescale 1ns / 1ps

module clockGen(
    input logic clk_100m,
    input logic reset,
    output logic clk_25m,
    output logic locked,
    output logic hclk,
    output logic vclk,
    output logic dValid_h,
    output logic dValid_v
    );

logic clk_25m_int, locked_int;

//----------------------------------------------------------------------------
//  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
//   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
//----------------------------------------------------------------------------
// _clk_25m____25.173______0.000______50.0______319.783____246.739
//
//----------------------------------------------------------------------------
// Input Clock   Freq (MHz)    Input Jitter (UI)
//----------------------------------------------------------------------------
// __primary_________100.000____________0.010

pixel_clk pixel_clk_gen
(
    // Clock in ports
    .clk_100m(clk_100m),    // input clk_100m

    // Clock out ports
    .clk_25m(clk_25m_int),  // output clk_25m

    // Status and control signals
    .reset(reset),          // input reset
    .locked(locked_int)     // output locked
);

horzTiming horzgen(.pixelClk(clk_25m_int), .rst(locked_int), .hclk(hclk), .dataValid(dValid_h));
vertTiming vertgen(.pixelClk(clk_25m_int), .rst(locked_int), .vclk(vclk), .dataValid(dValid_v));
assign locked = locked_int;
assign clk_25m = clk_25m_int;

endmodule