import defines::FLIPPER_INITIAL_Y;
import defines::FLIPPER_HEIGHT_Y, defines::FLIPPER_WIDTH_X;

module flipper_dual_block(
	input	logic			clk,
	input	logic			resetN,
	input 	logic	[10:0] 	pixelX,
	input 	logic 	[10:0] 	pixelY,
	input 	logic 			startOfFrame,
	input	logic			pause,
	input	logic			reset_level,
	input	logic			key2IsPressed,
	output	logic	[7:0]	RGB_flipper,
	output	logic			drawFlipper,
	output	logic	[31:0]	speedX
);

assign speedX = 0;

logic [10:0] topLeftXLeft;
logic [10:0] topLeftXRight;

flipper_dual_controller flipper_dual_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.key2IsPressed(key2IsPressed),
	.pause(pause),
	.reset_level(reset_level),
// output
	.topLeftXLeft(topLeftXLeft),
	.topLeftXRight(topLeftXRight)
);

logic drawLeft;

square_dynamic #(.OBJECT_WIDTH(FLIPPER_WIDTH_X), .OBJECT_HEIGHT(FLIPPER_HEIGHT_Y)) square_dynamic_inst_left(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(topLeftXLeft),
	.topLeftY(FLIPPER_INITIAL_Y),
// output
	.draw(drawLeft),
);

logic drawRight;

square_dynamic #(.OBJECT_WIDTH(FLIPPER_WIDTH_X), .OBJECT_HEIGHT(FLIPPER_HEIGHT_Y)) square_dynamic_inst_right(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(topLeftXRight),
	.topLeftY(FLIPPER_INITIAL_Y),
// output
	.draw(drawRight),
);

assign drawFlipper = drawLeft || drawRight;

object #(.COLOR(FLIPPER_COLOR)) object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.insideObject(drawFlipper),
// output
	.RGBObject(RGB_flipper)
);

endmodule
