import defines::SCREEN_MAIN_SPRING_WIDTH, defines::SCREEN_MAIN_SPRING_HEIGHT;
import defines::SCREEN_MAIN_SPRING_TOP_LEFT_X;

module spring_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input	logic 					key5IsPressed,
	input	logic					startOfFrame,
	input	logic					reset_level,
	output	logic			[7:0]	RGBSpring,
	output 	logic 					drawSpring,
	output	int						speedY
);

logic signed [10:0] topLeftY;

spring_controller spring_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key5IsPressed(key5IsPressed),
	.startOfFrame(startOfFrame),
	.reset_level(reset_level),
// output
	.topLeftY(topLeftY),
	.speedY(speedY)
);

logic 			drawSquare;
logic [10:0] 	offsetXSquare;
logic [10:0] 	offsetYSquare;

square_dynamic #(.OBJECT_WIDTH(SCREEN_MAIN_SPRING_WIDTH), .OBJECT_HEIGHT(SCREEN_MAIN_SPRING_HEIGHT)) square_dynamic_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(SCREEN_MAIN_SPRING_TOP_LEFT_X),
	.topLeftY(topLeftY),
// output
	.draw(drawSquare),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare)
);

spring_bitmap spring_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare),
	.insideRectangle(drawSquare),
// output
	.drawSpring(drawSpring),
	.RGBSpring(RGBSpring)
);

endmodule
