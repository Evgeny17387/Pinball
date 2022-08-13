import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;
import defines::SCREEN_MAIN_EQUATION_TOP_LEFT_X, defines::SCREEN_MAIN_EQUATION_TOP_LEFT_Y;

module equation_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input	logic	[3:0] 	scoreNumber,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawEquation,
	output	logic	[28:0]	RGBEquation
);

logic [10:0] 	offsetX;
logic [10:0] 	offsetY;
logic 			insideRectangle;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(SCREEN_MAIN_EQUATION_TOP_LEFT_X), .TOP_LEFT_Y(SCREEN_MAIN_EQUATION_TOP_LEFT_Y)) square_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(insideRectangle),
	.offsetX(offsetX),
	.offsetY(offsetY)
);

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.number(scoreNumber),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawEquation),
	.RGBNumber(RGBEquation)
);

endmodule
