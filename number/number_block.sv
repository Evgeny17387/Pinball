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

logic [10:0] 	offsetXNumber;
logic [10:0] 	offsetYNumber;

logic 			insideRectangleNumber;

square_object #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT)) square_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(TOP_LEFT_X),
	.topLeftY(TOP_LEFT_Y),
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
	.number(number),
	.insideRectangle(insideRectangleNumber),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

endmodule
