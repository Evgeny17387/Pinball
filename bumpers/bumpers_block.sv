import defines::BUMPER_COLOR;

module bumpers_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic			[7:0]	RGBBumper,
	output 	logic 					drawBumper
);

logic 			drawTriangle1;

triangle #(.OBJECT_WIDTH(128), .OBJECT_HEIGHT(64), .TOP_LEFT_X(1), .TOP_LEFT_Y(400), .ORIENTATION(0)) triangle_1_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawTriangle1)
);

logic [7:0] RGBTriangle1;

object #(.COLOR(BUMPER_COLOR)) object_1_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.insideObject(drawTriangle1),
// output
	.RGBObject(RGBTriangle1)
);

logic 			drawTriangle2;

triangle #(.OBJECT_WIDTH(128), .OBJECT_HEIGHT(64), .TOP_LEFT_X(400), .TOP_LEFT_Y(400), .ORIENTATION(1)) triangle_2_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawTriangle2)
);

logic [7:0] RGBTriangle2;

object #(.COLOR(BUMPER_COLOR)) object_2_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.insideObject(drawTriangle2),
// output
	.RGBObject(RGBTriangle2)
);

logic 			drawSquare;
logic [10:0] 	offsetXSquare;
logic [10:0] 	offsetYSquare;
logic [7:0] 	RGBBumper1;
logic			drawBumper1;

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
	.drawBumper(drawBumper1),
	.RGBBumper(RGBBumper1)
);

assign drawBumper 	= drawBumper1 ? drawBumper1 : drawTriangle1 ? drawTriangle1 : drawTriangle2;
assign RGBBumper 	= drawBumper1 ? RGBBumper1 : drawTriangle1 ? RGBTriangle1 : RGBTriangle2;

endmodule
