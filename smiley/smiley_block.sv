module smiley_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	PixelX,
	input 	logic signed	[10:0] 	PixelY,
	input 	logic 					startOfFrame,
	input 	logic 					collisionSmileyBorderTop,
	input 	logic 					collisionSmileyBorderLeft,
	input 	logic 					collisionSmileyBorderRight,
	input 	logic					collisionSmileyFlipper,
	input	logic					key5IsPressed,
	input	logic					pause,
	input	logic			[31:0]	flipperSpeedX,
	output	logic			[7:0]	RGB_smiley,
	output	logic					draw_smiley
);

logic 					draw_smiley_inner;

logic 			[10:0] 	smileyOffsetX;
logic 			[10:0] 	smileyOffsetY;

logic signed 	[10:0] 	topLeftX;
logic signed 	[10:0] 	topLeftY;

smiley_controller smiley_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.collisionSmileyBorderTop(collisionSmileyBorderTop),
	.collisionSmileyBorderLeft(collisionSmileyBorderLeft),
	.collisionSmileyBorderRight(collisionSmileyBorderRight),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.key5IsPressed(key5IsPressed),
	.pause(pause),
	.flipperSpeedX(flipperSpeedX),
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
	.draw(draw_smiley_inner)
);

smiley_bitmap smiley_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(smileyOffsetX),
	.offsetY(smileyOffsetY),
	.InsideRectangle(draw_smiley_inner),
// output
	.RGB_smiley(RGB_smiley),
	.draw_smiley(draw_smiley)
);

endmodule
