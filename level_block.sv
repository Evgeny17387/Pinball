import defines::LEVEL_TOP_LEFT_X, defines::LEVEL_TOP_LEFT_Y;

module level_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input	logic	[3:0] 	level,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawLevel,
	output	logic	[28:0]	RGBLevel
);

logic [10:0] offsetX;
logic [10:0] offsetY;

logic insideRectangle;

square_object #(.OBJECT_WIDTH_X(16), .OBJECT_HEIGHT_Y(32)) square_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(LEVEL_TOP_LEFT_X),
	.topLeftY(LEVEL_TOP_LEFT_Y),
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
	.number(level),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawLevel),
	.RGBNumber(RGBLevel)
);

endmodule
