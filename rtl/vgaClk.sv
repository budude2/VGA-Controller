`timescale 1ns / 1ps

module vgaClk(
    input logic pixelClk,
    input logic locked,

    output logic hClk,
    output logic hVis,
    output logic [9:0] xCor,

    output logic vClk,
    output logic vVis,
    output logic [9:0] yCor
    );

logic [18:0] pixelCount;

always_ff @(posedge pixelClk) begin
    if(~locked) begin
        xCor <= 0;
        yCor <= 0;
    end
    else begin
        if(xCor < 799) begin
            xCor <= xCor + 1;
        end
        else if(xCor == 799 & yCor < 524) begin
            xCor <= 0;
            yCor <= yCor + 1;
        end
        else if(xCor == 799 & yCor == 524) begin
            xCor <= 0;
            yCor <= 0;
        end
    end
end

always_comb begin
    if(xCor < 640) begin                    // Visible Portion
        hClk = 1'b1;
        hVis = 1'b1;
    end
    else if(xCor >= 640 & xCor < 656) begin  // Front Porch
        hClk = 1'b1;
        hVis = 1'b0;
    end
    else if(xCor >= 656 & xCor < 752) begin  // Sync
        hClk = 1'b0;
        hVis = 1'b0;
    end
    else begin                              // Back Porch
        hClk = 1'b1;
        hVis = 1'b0;
    end
end

always_comb begin
    if(yCor < 480) begin                    // Visible Portion
        vClk = 1'b1;
        vVis = 1'b1;
    end
    else if(yCor >= 480 & yCor < 490) begin  // Front Porch
        vClk = 1'b1;
        vVis = 1'b0;
    end
    else if(yCor >= 490 & yCor < 492) begin  // Sync
        vClk = 1'b0;
        vVis = 1'b0;
    end
    else begin                              // Back Porch
        vClk = 1'b1;
        vVis = 1'b0;
    end
end

endmodule