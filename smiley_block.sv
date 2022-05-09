module smiley_block(
	input		logic							clk,
	input		logic							resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input 	logic 						startOfFrame,
	input		logic							Y_direction,
	input		logic							toggleX,
	input 	logic							collision,
	output	logic				[7:0]		RGBout,
	output	logic							smileyDrawingRequest
);

logic smileyRecDR;

logic [10:0] smileyOffsetX;
logic [10:0] smileyOffsetY;

logic signed [10:0] topLeftX;
logic signed [10:0] topLeftY;

logic	[3:0] HitEdgeCode;

smileyface_moveCollision smileyface_moveCollision_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.Y_direction(Y_direction),
	.toggleX(toggleX),
	.collision(collision),
	.HitEdgeCode(HitEdgeCode),
// output
	.topLeftX(topLeftX),
	.topLeftY(topLeftY)
);

square_object square_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(topLeftX),
	.topLeftY(topLeftY),
// output
	.offsetX(smileyOffsetX),
	.offsetY(smileyOffsetY),
	.drawingRequest(smileyRecDR)
);

smileyBitMap smileyBitMap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(smileyOffsetX),
	.offsetY(smileyOffsetY),
	.InsideRectangle(smileyRecDR),
// output
	.RGBout(RGBout),
	.HitEdgeCode(HitEdgeCode),
	.drawingRequest(smileyDrawingRequest)
);

endmodule
