import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;

module Obstacle(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input 	logic 			[4:0] 	goodNumber,
	output	logic					drawObstacle,
	output	logic			[7:0]	RGBObstacle,
	output 	logic 					drawGoodNumber
);

logic [10:0] 	offsetX;
logic [10:0] 	offsetY;
logic 			insideRectangle;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(200), .TOP_LEFT_Y(200)) square_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(insideRectangle),
	.offsetX(offsetX),
	.offsetY(offsetY)
);

logic			drawNumber;
logic	[7:0]	RGBNumber;

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.number(goodNumber),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

assign drawObstacle = drawNumber;

assign RGBObstacle = RGBNumber;

assign drawGoodNumber = drawNumber && (2 == goodNumber ? 1'b1 : 1'b0);

endmodule
