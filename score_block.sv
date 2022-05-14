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

localparam logic signed [10:0] topLeftX = 50;
localparam logic signed [10:0] topLeftY = 50;

square_object #(.OBJECT_WIDTH_X(16), .OBJECT_HEIGHT_Y(32)) square_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(topLeftX),
	.topLeftY(topLeftY),
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
