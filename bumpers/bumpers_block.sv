import defines::BUMPER_COLOR;

module bumpers_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic			[7:0]	RGBBumper,
	output 	logic 					drawBumper,
	output	COLLISION_FACTOR		collisionFactor
);

logic drawTriangle1;

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

logic drawTriangle2;

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

logic drawTriangle3;

triangle #(.OBJECT_WIDTH(128), .OBJECT_HEIGHT(64), .TOP_LEFT_X(490), .TOP_LEFT_Y(60), .ORIENTATION(2)) triangle_3_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawTriangle3)
);

logic [7:0] RGBTriangle3;

object #(.COLOR(BUMPER_COLOR)) object_3_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.insideObject(drawTriangle3),
// output
	.RGBObject(RGBTriangle3)
);

assign drawBumper 	= drawTriangle1 || drawTriangle2 || drawTriangle3;
assign RGBBumper 	= drawTriangle1 ? RGBTriangle1 : drawTriangle2 ? RGBTriangle2 : RGBTriangle3;

assign collisionFactor.xxFactor = drawTriangle3 ? 0 : drawTriangle1 ? 0 : 0;
assign collisionFactor.yyFactor = drawTriangle3 ? 0 : drawTriangle1 ? 0 : 0;
assign collisionFactor.xyFactor = drawTriangle3 ? 2 : drawTriangle1 ? 2 : -2;
assign collisionFactor.yxFactor = drawTriangle3 ? 2 : drawTriangle1 ? 2 : -2;

endmodule
