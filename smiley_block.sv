module smiley_block(
	input		logic							clk,
	input		logic							resetN,
	input 	logic signed	[10:0] 	PixelX,
	input 	logic signed	[10:0] 	PixelY,
	input 	logic 						startOfFrame,
	input		logic							Y_direction,
	input		logic							toggleX,
	input 	logic							collision,
	output	logic				[7:0]		RGB_smiley,
	output	logic							draw_smiley
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
	.PixelX(PixelX),
	.PixelY(PixelY),
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
	.RGB_smiley(RGB_smiley),
	.HitEdgeCode(HitEdgeCode),
	.draw_smiley(draw_smiley)
);

endmodule
