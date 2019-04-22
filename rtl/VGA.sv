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

logic dValid_h, dValid_v, pixelClk, locked_i, hclk_i, vclk_i, dispValid, dispValid_q;
logic [9:0] xCor, yCor;
logic [18:0] addr;
logic [3:0] data;

clockGen pixelClkGen(.clk_100m(clk_100m), .reset(reset), .clk_25m(pixelClk), .locked(locked_i));
vgaClk vgaTiming(.pixelClk(pixelClk), .locked(locked_i), .hClk(hclk_i), .vClk(vclk_i), .xCor(xCor), .yCor(yCor), .hVis(dValid_h), .vVis(dValid_v));

assign addr = xCor + 640 * yCor;
assign dispValid = dValid_h & dValid_v;

blk_mem_gen_0 frameBuf
(
  .clka(pixelClk),  // input wire clka
  .ena(dispValid),  // input wire ena
  .addra(addr),     // input wire [18 : 0] addra
  .douta(data)      // output wire [3 : 0] douta
);

always_ff @(posedge pixelClk) begin
    hclk <= hclk_i;
    vclk <= vclk_i;
    dispValid_q <= dispValid;
end

always_comb begin
    if(dispValid_q) begin
        case(data)
            0:
                begin
                    VGA_R = 4'hf;
                    VGA_G = 4'hf;
                    VGA_B = 4'hf;
                end
            1:
                begin
                    VGA_R = 4'he;
                    VGA_G = 4'hf;
                    VGA_B = 4'hf;
                end
            2:
                begin
                    VGA_R = 4'hf;
                    VGA_G = 4'hf;
                    VGA_B = 4'hc;
                end
            3:
                begin
                    VGA_R = 4'hf;
                    VGA_G = 4'he;
                    VGA_B = 4'hb;
                end
            4:
                begin
                    VGA_R = 4'hf;
                    VGA_G = 4'hd;
                    VGA_B = 4'h7;
                end
            5:
                begin
                    VGA_R = 4'hd;
                    VGA_G = 4'hd;
                    VGA_B = 4'ha;
                end
            6:
                begin
                    VGA_R = 4'hf;
                    VGA_G = 4'hd;
                    VGA_B = 4'h4;
                end
            7:
                begin
                    VGA_R = 4'hf;
                    VGA_G = 4'hc;
                    VGA_B = 4'h4;
                end
            8:
                begin
                    VGA_R = 4'hf;
                    VGA_G = 4'hc;
                    VGA_B = 4'h3;
                end
            9:
                begin
                    VGA_R = 4'he;
                    VGA_G = 4'hc;
                    VGA_B = 4'h4;
                end
            10:
                begin
                    VGA_R = 4'hc;
                    VGA_G = 4'hb;
                    VGA_B = 4'h8;
                end
            11:
                begin
                    VGA_R = 4'hd;
                    VGA_G = 4'h9;
                    VGA_B = 4'h5;
                end
            12:
                begin
                    VGA_R = 4'hc;
                    VGA_G = 4'h5;
                    VGA_B = 4'h4;
                end
            13:
                begin
                    VGA_R = 4'h8;
                    VGA_G = 4'h7;
                    VGA_B = 4'h4;
                end
            14:
                begin
                    VGA_R = 4'ha;
                    VGA_G = 4'h3;
                    VGA_B = 4'h2;
                end
            15:
                begin
                    VGA_R = 4'h1;
                    VGA_G = 4'h1;
                    VGA_B = 4'h1;
                end
        endcase // data
    end
    else begin
        VGA_R = 0;
        VGA_G = 0;
        VGA_B = 0;
    end
end

assign locked = locked_i;

endmodule