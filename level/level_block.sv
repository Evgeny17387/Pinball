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

logic [10:0] 	offsetXNumber;
logic [10:0] 	offsetYNumber;

logic 			insideRectangleNumber;

square_object #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT)) square_object_number_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(LEVEL_NUMBER_TOP_LEFT_X),
	.topLeftY(LEVEL_NUMBER_TOP_LEFT_Y),
// output
	.offsetX(offsetXNumber),
	.offsetY(offsetYNumber),
	.draw(insideRectangleNumber),
);

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXNumber),
	.offsetY(offsetYNumber),
	.number(level),
	.insideRectangle(insideRectangleNumber),
// output
	.drawNumber(drawLevel),
	.RGBNumber(RGBLevel)
);

endmodule
