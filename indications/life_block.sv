import defines::LIFE_WIDTH, defines::LIFE_HEIGHT;
import defines::LIFE_TOP_LEFT_X, defines::LIFE_TOP_LEFT_Y;
import defines::LIFE_SPACE;

module life_block
#(parameter LIFE_INIT)
(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic	[3:0] 	life,
	output	logic			drawLife,
	output	logic	[7:0]	RGBLife
);

logic insideRectangle;
logic drawSquare [LIFE_INIT-1:0];

logic [10:0] offsetX;
logic [10:0] offsetY;
logic [10:0] offsetXSquare [LIFE_INIT-1:0];
logic [10:0] offsetYSquare [LIFE_INIT-1:0];

genvar i;
generate
    for (i = 0; i < LIFE_INIT; i = i + 1) begin : block_squares_inst
        square #(
                .OBJECT_WIDTH(LIFE_WIDTH),
                .OBJECT_HEIGHT(LIFE_HEIGHT),
                .TOP_LEFT_X(LIFE_TOP_LEFT_X + i * LIFE_SPACE),
                .TOP_LEFT_Y(LIFE_TOP_LEFT_Y)
                ) square_inst_0 (
        // input
            .pixelX(pixelX),
            .pixelY(pixelY),
        // output
            .draw(drawSquare[i]),
            .offsetX(offsetXSquare[i]),
            .offsetY(offsetYSquare[i])
        );
    end
endgenerate

always_comb begin

	insideRectangle = 0;

    for (int i = 0; i < LIFE_INIT; i = i + 1) begin
        if (i < life) begin
		    insideRectangle = insideRectangle | drawSquare[i];
        end
    end

end

always_comb begin
    offsetX = offsetXSquare[0];
    offsetY = offsetYSquare[0];

    for (int i = 1; i < LIFE_INIT; i = i + 1) begin
        if (i < life) begin
            if (drawSquare[i]) begin
                offsetX = offsetXSquare[i];
                offsetY = offsetYSquare[i];
            end
        end
    end
end

life_bitmap life_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.insideRectangle(insideRectangle),
// output
	.drawLife(drawLife),
	.RGBLife(RGBLife)
);

endmodule
