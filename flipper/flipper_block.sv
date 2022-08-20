import defines::FLIPPER_INITIAL_Y;
import defines::FLIPPER_HEIGHT_Y, defines::FLIPPER_WIDTH_X;

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
	input 	logic 					collisionFlipperFrame,
	output	logic			[7:0]	RGB_flipper,
	output	logic					drawFlipper,
	output	logic			[31:0]	speedX
);

logic signed [10:0] topLeftX;

flipper_controller flipper_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
	.pause(pause),
	.reset_level(reset_level),
	.collisionFlipperFrame(collisionFlipperFrame),
	.hitEdgeCode(hitEdgeCode),
// output
	.topLeftX(topLeftX),
	.speedX(speedX)
);

logic 			insideBracket;
logic [10:0] 	offsetX;
logic [10:0] 	offsetY;

square_dynamic #(.OBJECT_WIDTH(FLIPPER_WIDTH_X), .OBJECT_HEIGHT(FLIPPER_HEIGHT_Y)) square_dynamic_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(topLeftX),
	.topLeftY(FLIPPER_INITIAL_Y),
// output
	.draw(insideBracket),
	.offsetX(offsetX),
	.offsetY(offsetY)
);

logic [3:0] hitEdgeCode;

flipper_object flipper_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.insideBracket(insideBracket),
// output
	.draw(drawFlipper),
	.RGB(RGB_flipper),
	.hitEdgeCode(hitEdgeCode)
);

endmodule
