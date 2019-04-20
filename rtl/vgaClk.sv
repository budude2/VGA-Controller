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

always_ff @(posedge pixelClk or negedge locked) begin : proc_pixelCount
    if(~locked) begin
        pixelCount <= 0;
    end
    else if(pixelCount > 419998) begin
        pixelCount <= 0;
    end
    else begin
        pixelCount <=  pixelCount + 1;
    end
end

assign xCor = pixelCount % 800;
assign yCor = pixelCount / 800;

always_comb begin
    if(xCor < 639) begin                    // Visible Portion
        hClk = 1'b1;
        hVis = 1'b1;
    end
    else if(xCor > 639 & xCor < 655) begin  // Front Porch
        hClk = 1'b1;
        hVis = 1'b0;
    end
    else if(xCor > 655 & xCor < 751) begin  // Sync
        hClk = 1'b0;
        hVis = 1'b0;
    end
    else begin                              // Back Porch
        hClk = 1'b1;
        hVis = 1'b0;
    end
end

always_comb begin
    if(yCor < 479) begin                    // Visible Portion
        vClk = 1'b1;
        vVis = 1'b1;
    end
    else if(yCor > 479 & yCor < 489) begin  // Front Porch
        vClk = 1'b1;
        vVis = 1'b0;
    end
    else if(yCor > 489 & yCor < 491) begin  // Sync
        vClk = 1'b0;
        vVis = 1'b0;
    end
    else begin                              // Back Porch
        vClk = 1'b1;
        vVis = 1'b0;
    end
end

endmodule