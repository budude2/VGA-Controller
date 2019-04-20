`timescale 1ns / 1ps

module patternGen
    (
        input logic pixelClk,
        input logic locked,
        input logic dValid,
        input logic [9:0] xCor,
        input logic [9:0] yCor,
        output logic [3:0] R,
        output logic [3:0] G,
        output logic [3:0] B
    );

always_ff @(posedge pixelClk or negedge locked) begin
    if(~locked) begin
        R <= 0;
        G <= 0;
        B <= 0;
    end
    else if(dValid) begin
        if(xCor > 158 & xCor < 253) begin
            R <= 15;
            G <= 0;
            B <= 0;
        end
        else if(xCor > 253 & xCor < 344) begin
            R <= 15;
            G <= 8;
            B <= 0;
        end
        else if(xCor > 344 & xCor < 435) begin
            R <= 15;
            G <= 15;
            B <= 0;
        end
        else if(xCor > 435 & xCor < 526) begin
            R <= 0;
            G <= 15;
            B <= 0;
        end
        else if(xCor > 526 & xCor < 617) begin
            R <= 0;
            G <= 0;
            B <= 15;
        end
        else if(xCor > 617 & xCor < 708) begin
            R <= 8;
            G <= 0;
            B <= 15;
        end
        else if(xCor > 708 & xCor < 799) begin
            R <= 15;
            G <= 0;
            B <= 15;
        end
    end
    else begin
        R <= 0;
        G <= 0;
        B <= 0;
    end
end

endmodule
