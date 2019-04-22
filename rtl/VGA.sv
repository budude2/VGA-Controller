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

logic dValid_h, dValid_v, pixelClk, locked_i, hclk_i, vclk_i;
logic [9:0] xCor, yCor;
logic [18:0] addr;
logic [3:0] douta;

clockGen pixelClkGen(.clk_100m(clk_100m), .reset(reset), .clk_25m(pixelClk), .locked(locked_i));
vgaClk vgaTiming(.pixelClk(pixelClk), .locked(locked_i), .hClk(hclk_i), .vClk(vclk_i), .xCor(xCor), .yCor(yCor), .hVis(dValid_h), .vVis(dValid_v));
assign addr = xCor + 640 * yCor;

blk_mem_gen_0 frameBuf
(
  .clka(pixelClk),                  // input wire clka
  .ena(dValid_h & dValid_v),        // input wire ena
  .addra(addr),                     // input wire [18 : 0] addra
  .douta(douta)                     // output wire [3 : 0] douta
);

always_ff @(posedge pixelClk) begin
    hclk <= hclk_i;
    vclk <= vclk_i;
end

always_comb begin
    if(dValid_h & dValid_v) begin
        if(douta == 0) begin
            VGA_R = 0;
            VGA_G = 0;
            VGA_B = 0;
        end
        else begin
            VGA_R = 15;
            VGA_G = 15;
            VGA_B = 15;
        end
    end
    else begin
        VGA_R = 0;
        VGA_G = 0;
        VGA_B = 0;
    end
end

assign locked = locked_i;

endmodule