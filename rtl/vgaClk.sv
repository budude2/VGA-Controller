`timescale 1ns / 1ps

module vgaClk(
    input logic pixelClk,
    input logic locked,
    output logic vClk,
    output logic hClk,
    output logic [9:0] xCor,
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

endmodule