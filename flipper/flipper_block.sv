module flipper_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input 	logic 					startOfFrame,
	input	logic					key4IsPressed,
	input	logic					key6IsPressed,
	input	logic					pause,
	input	logic					reset_level,
	input 	logic 					collisionFlipperBorderLeft,
	input 	logic 					collisionFlipperBorderRight,
	output	logic			[7:0]	RGB_flipper,
	output	logic					drawFlipper,
	output	logic			[31:0]	speedX
);

logic signed [10:0] topLeftX;
logic signed [10:0] topLeftY;

flipper_controller flipper_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
	.pause(pause),
	.reset_level(reset_level),
	.collisionFlipperBorderLeft(collisionFlipperBorderLeft),
	.collisionFlipperBorderRight(collisionFlipperBorderRight),
// output
	.topLeftX(topLeftX),
	.topLeftY(topLeftY),
	.speedX(speedX)
);

flipper_object flipper_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(topLeftX),
	.topLeftY(topLeftY),
// output
	.draw(drawFlipper),
	.RGB(RGB_flipper)
);

endmodule
