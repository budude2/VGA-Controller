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

logic dValid_h, dValid_v, pixelClk, mbClk, locked_i, hclk_i, vclk_i, dispValid, dispValid_q;
logic [9:0] xCor, yCor;
logic [18:0] addr;
logic [31:0] addrBram;
logic [4:0] addrSel;
logic [31:0] bramData;
logic [3:0] vidData;

clockGen pixelClkGen
(
    .clk_100m(clk_100m),
    .reset(reset),
    .clk_25m(pixelClk),
    .clk_100m_o(mbClk),
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
assign addrBram     = addr / 8;
assign addrSel      = addr % 8;

microblaze_wrapper controller
(
    .bram_addr(addrBram),
    .bram_clk(pixelClk),
    .bram_dout(bramData),
    .bram_en(dispValid),
    .clk_100MHz(mbClk),
    .locked(locked_i),
    .rst(reset)
);

//assign vidData = bramData[(addrSel << 2) +: 4];
//assign vidData = bramData[addrSel * 4 +: 4];

always_comb begin
    case(addrSel)
        0: vidData = bramData[3:0];
        1: vidData = bramData[7:4];
        2: vidData = bramData[11:8];
        3: vidData = bramData[15:12];
        4: vidData = bramData[19:16];
        5: vidData = bramData[23:20];
        6: vidData = bramData[27:24];
        7: vidData = bramData[31:28];
    endcase
end

always_ff @(posedge pixelClk) begin
    hclk        <= hclk_i;
    vclk        <= vclk_i;
    dispValid_q <= dispValid;
end

always_comb begin
    if(dispValid_q) begin
        case(vidData)
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