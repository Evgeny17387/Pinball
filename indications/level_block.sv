import defines::LEVEL_NUMBER_TOP_LEFT_X, defines::LEVEL_NUMBER_TOP_LEFT_Y;
import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;

module level_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input	logic	[3:0] 	level,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawLevel,
	output	logic	[28:0]	RGBLevel
);

logic [10:0] 	offsetX;
logic [10:0] 	offsetY;

logic 			draw;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(LEVEL_NUMBER_TOP_LEFT_X), .TOP_LEFT_Y(LEVEL_NUMBER_TOP_LEFT_Y)) square_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.offsetX(offsetX),
	.offsetY(offsetY),
	.draw(draw),
);

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.number(level),
	.insideRectangle(draw),
// output
	.drawNumber(drawLevel),
	.RGBNumber(RGBLevel)
);

endmodule
