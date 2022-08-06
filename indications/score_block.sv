import defines::SCORE_TOP_LEFT_X, defines::SCORE_TOP_LEFT_Y;
import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;

module score_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input	logic	[3:0] 	score,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawScore,
	output	logic	[28:0]	RGBScore
);

logic [10:0] offsetX;
logic [10:0] offsetY;

logic insideRectangle;

square_object #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT)) square_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(SCORE_TOP_LEFT_X),
	.topLeftY(SCORE_TOP_LEFT_Y),
// output
	.offsetX(offsetX),
	.offsetY(offsetY),
	.draw(insideRectangle),
);

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.number(score),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawScore),
	.RGBNumber(RGBScore)
);

endmodule
