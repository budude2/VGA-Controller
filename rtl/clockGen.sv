`timescale 1ns / 1ps

module clockGen(
    input logic clk_100m,
    input logic reset,
    output logic clk_25m,
    output logic clk_100m_o,
    output logic locked
    );

logic clk_25m_i, locked_i;

//----------------------------------------------------------------------------
//  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
//   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
//----------------------------------------------------------------------------
// _clk_25m____25.175______0.000______50.0______319.783____246.739
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
    .clk_25m(clk_25m_i),  // output clk_25m
    .clk_100m_o(clk_100m_o),     // output clk_100m_o

    // Status and control signals
    .reset(reset),          // input reset
    .locked(locked_i)     // output locked
);

assign locked = locked_i;
assign clk_25m = clk_25m_i;

endmodule