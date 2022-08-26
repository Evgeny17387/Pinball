import defines::FLIPPER_INITIAL_Y;
import defines::FLIPPER_HEIGHT_Y, defines::FLIPPER_WIDTH_X;

module flipper_block(
	input	logic			clk,
	input	logic			resetN,
	input 	logic	[10:0] 	pixelX,
	input 	logic 	[10:0] 	pixelY,
	input 	logic			startOfFrame,
	input	logic			key2IsPressed,
	input	logic			key4IsPressed,
	input	logic			key6IsPressed,
	input	logic			pause,
	input	logic			reset_level,
	input 	logic			collisionFlipperFrame,
	input	logic			flipperType,
	output	logic	[7:0]	RGB_flipper,
	output	logic			drawFlipper,
	output	logic	[31:0]	speedX
);

logic	[7:0]	RGB_flipper_single;
logic			drawFlipper_single;
logic	[31:0]	flipperSpeedX_single;

flipper_single_block flipper_single_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.startOfFrame(startOfFrame),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
	.pause(pause),
	.reset_level(reset_level),
	.collisionFlipperFrame(collisionFlipperFrame),
// output
	.RGB_flipper(RGB_flipper_single),
	.drawFlipper(drawFlipper_single),
	.speedX(flipperSpeedX_single)
);

logic	[7:0]	RGB_flipper_dual;
logic			drawFlipper_dual;
logic	[31:0]	flipperSpeedX_dual;

flipper_dual_block flipper_dual_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.startOfFrame(startOfFrame),
	.key2IsPressed(key2IsPressed),
	.pause(pause),
	.reset_level(reset_level),
// output
	.RGB_flipper(RGB_flipper_dual),
	.drawFlipper(drawFlipper_dual),
	.speedX(flipperSpeedX_dual)
);

assign RGB_flipper = flipperType == 0 ? RGB_flipper_single : RGB_flipper_dual;
assign drawFlipper = flipperType == 0 ? drawFlipper_single : drawFlipper_dual;
assign speedX = flipperType == 0 ? flipperSpeedX_single : flipperSpeedX_dual;

endmodule
