import defines_ball::WIDTH, defines_ball::HEIGHT;

module smiley_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input 	logic 					startOfFrame,
	input 	logic					collisionSmileyFlipper,
	input	logic					key5IsPressed,
	input	logic					pause,
	input	logic			[31:0]	flipperSpeedX,
	input	logic					reset_level,
	input	logic 					collisionSmileyObstacle,
	input	logic 			[3:0]	level,
	input	logic					collisionSmileySpringPulse,
	input	int						springSpeedY,
	input	logic					collisionSmileyBumperPulse,
	input	logic					collisionSmileyFrame,
	output	logic			[7:0]	RGB_smiley,
	output	logic					draw_smiley
);

logic 					draw_smiley_inner;

logic 			[10:0] 	smileyOffsetX;
logic 			[10:0] 	smileyOffsetY;

logic signed 	[10:0] 	topLeftX;
logic signed 	[10:0] 	topLeftY;

logic			[3:0]	hitEdgeCode;

smiley_controller smiley_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.key5IsPressed(key5IsPressed),
	.pause(pause),
	.flipperSpeedX(flipperSpeedX),
	.reset_level(reset_level),
	.hitEdgeCode(hitEdgeCode),
	.collisionSmileyObstacle(collisionSmileyObstacle),
	.level(level),
	.collisionSmileySpringPulse(collisionSmileySpringPulse),
	.springSpeedY(springSpeedY),
	.collisionSmileyBumperPulse(collisionSmileyBumperPulse),
	.collisionSmileyFrame(collisionSmileyFrame),
// output
	.topLeftX(topLeftX),
	.topLeftY(topLeftY)
);

// ToDo: make sure width\height of the object and bitmap are equal
square_object #(.OBJECT_WIDTH(defines_ball::WIDTH), .OBJECT_HEIGHT(defines_ball::HEIGHT)) square_object_inst(
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
	.draw_smiley(draw_smiley),
	.hitEdgeCode(hitEdgeCode)
);

endmodule
