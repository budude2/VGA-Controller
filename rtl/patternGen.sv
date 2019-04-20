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
        if(xCor > 0 & xCor < 94) begin
            R <= 15;
            G <= 0;
            B <= 0;
        end
        else if(xCor > 94 & xCor < 185) begin
            R <= 15;
            G <= 8;
            B <= 0;
        end
        else if(xCor > 185 & xCor < 276) begin
            R <= 15;
            G <= 15;
            B <= 0;
        end
        else if(xCor > 276 & xCor < 367) begin
            R <= 0;
            G <= 15;
            B <= 0;
        end
        else if(xCor > 367 & xCor < 458) begin
            R <= 0;
            G <= 0;
            B <= 15;
        end
        else if(xCor > 458 & xCor < 549) begin
            R <= 8;
            G <= 0;
            B <= 15;
        end
        else if(xCor > 549 & xCor < 639) begin
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
