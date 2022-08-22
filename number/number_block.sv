import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;

module number_block
#(parameter TOP_LEFT_X = 0, TOP_LEFT_Y = 0)
(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic	[3:0] 	number,
	output	logic			drawNumber,
	output	logic	[7:0]	RGBNumber
);

logic [10:0] 	offsetX;
logic [10:0] 	offsetY;

logic 			draw;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(TOP_LEFT_X), .TOP_LEFT_Y(TOP_LEFT_Y)) square_object_inst(
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
	.number(number),
	.insideRectangle(draw),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

endmodule
