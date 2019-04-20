`timescale 1ns / 1ps

module pixelTracker
    (
        input pixelClk,
        input locked,
        output [9:0] xCor,
        output [9:0] yCor
    );

logic [18:0] pixelCount;

always_ff @(posedge pixelClk or negedge locked) begin : proc_pixelCount
    if(~locked) begin
        pixelCount <= 0;
    end
    else if(pixelCount > 419999) begin
        pixelCount <= 0;
    end
    else begin
        pixelCount <=  pixelCount + 1;
    end
end

assign xCor = pixelCount % 800;
assign yCor = pixelCount / 800;

endmodule
