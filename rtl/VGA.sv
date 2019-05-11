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

logic dValid_h, dValid_v, pixelClk, clk_123m, locked_i, dispValid, dispValid_q;
logic hclk_i, vclk_i, hclk_q, vclk_q;
logic [9:0] xCor, yCor;
logic [18:0] addr;
logic [31:0] addrBram, bramData;
logic [2:0] addrSel, addrSel_q;
logic [3:0] vidData;

clockGen pixelClkGen
(
    .clk_100m(clk_100m),
    .reset(reset),
    .clk_25m(pixelClk),
    .clk_123m(clk_123m),
    .locked(locked_i)
);

vgaClk vgaTiming
(
    .pixelClk(pixelClk),
    .locked(locked_i),
    .hClk(hclk_i),
    .vClk(vclk_i),
    .xCor(xCor),
    .yCor(yCor),
    .hVis(dValid_h),
    .vVis(dValid_v)
);

assign addr         = xCor + 640 * yCor;
assign dispValid    = dValid_h & dValid_v;
assign addrBram     = {14'b00000000000000, addr[18:1]};
assign addrSel      = addr % 8;

microblaze_wrapper controller
(
    .bram_addr(addrBram),
    .bram_clk(pixelClk),
    .bram_dout(bramData),
    .bram_en(dispValid),
    .clk_123m(clk_123m),
    .locked(locked_i),
    .rst(reset)
);

always_comb begin
    case(addrSel_q)
        7: vidData = bramData[3:0];
        6: vidData = bramData[7:4];
        5: vidData = bramData[11:8];
        4: vidData = bramData[15:12];
        3: vidData = bramData[19:16];
        2: vidData = bramData[23:20];
        1: vidData = bramData[27:24];
        0: vidData = bramData[31:28];
    endcase
end

always_ff @(posedge pixelClk) begin
    hclk_q      <= hclk_i;
    vclk_q      <= vclk_i;
    dispValid_q <= dispValid;
    addrSel_q	<= addrSel;
end

always_comb begin
    if(dispValid_q) begin
        case(vidData)
            0:  // Black
                begin
                    VGA_R = 4'h0;
                    VGA_G = 4'h0;
                    VGA_B = 4'h0;
                end
            1:  // Blue
                begin
                    VGA_R = 4'h0;
                    VGA_G = 4'h0;
                    VGA_B = 4'hA;
                end
            2:  // Green
                begin
                    VGA_R = 4'h0;
                    VGA_G = 4'hA;
                    VGA_B = 4'h0;
                end
            3:  // Cyan
                begin
                    VGA_R = 4'h0;
                    VGA_G = 4'hA;
                    VGA_B = 4'hA;
                end
            4:  // Red
                begin
                    VGA_R = 4'hA;
                    VGA_G = 4'h0;
                    VGA_B = 4'h0;
                end
            5:  // Magenta
                begin
                    VGA_R = 4'hA;
                    VGA_G = 4'h0;
                    VGA_B = 4'hA;
                end
            6: // Brown
                begin
                    VGA_R = 4'hA;
                    VGA_G = 4'h5;
                    VGA_B = 4'hA;
                end
            7:  // Gray
                begin
                    VGA_R = 4'hA;
                    VGA_G = 4'hA;
                    VGA_B = 4'hA;
                end
            8:  // Dark Grey
                begin
                    VGA_R = 4'h5;
                    VGA_G = 4'h5;
                    VGA_B = 4'h5;
                end
            9:  // Bright Blue
                begin
                    VGA_R = 4'h5;
                    VGA_G = 4'h5;
                    VGA_B = 4'hF;
                end
            10: // Bright Green
                begin
                    VGA_R = 4'h5;
                    VGA_G = 4'hF;
                    VGA_B = 4'h5;
                end
            11: // Bright Cyan
                begin
                    VGA_R = 4'h5;
                    VGA_G = 4'hF;
                    VGA_B = 4'hF;
                end
            12: // Bright Red
                begin
                    VGA_R = 4'hF;
                    VGA_G = 4'h5;
                    VGA_B = 4'h5;
                end
            13: // Bright Magenta
                begin
                    VGA_R = 4'hF;
                    VGA_G = 4'h5;
                    VGA_B = 4'hF;
                end
            14: // Yellow
                begin
                    VGA_R = 4'hF;
                    VGA_G = 4'hF;
                    VGA_B = 4'h5;
                end
            15: // White
                begin
                    VGA_R = 4'hF;
                    VGA_G = 4'hF;
                    VGA_B = 4'hF;
                end
        endcase // data
    end
    else begin
        VGA_R = 0;
        VGA_G = 0;
        VGA_B = 0;
    end
end

assign locked 	= locked_i;
assign hclk 	= hclk_q;
assign vclk 	= vclk_q;

endmodule