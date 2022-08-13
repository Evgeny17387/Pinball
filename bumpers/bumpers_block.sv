module bumpers_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic			[7:0]	RGBBumper,
	output 	logic 					drawBumper
);

logic 			drawSquare;
logic [10:0] 	offsetXSquare;
logic [10:0] 	offsetYSquare;

square #(.OBJECT_WIDTH(64), .OBJECT_HEIGHT(32), .TOP_LEFT_X(550), .TOP_LEFT_Y(60)) square_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawSquare),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare)
);

bumper_bitmap bumper_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare),
	.insideRectangle(drawSquare),
// output
	.drawBumper(drawBumper),
	.RGBBumper(RGBBumper)
);

endmodule
