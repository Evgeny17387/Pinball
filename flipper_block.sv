module flipper_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	PixelX,
	input 	logic signed	[10:0] 	PixelY,
	input 	logic 					startOfFrame,
	input	logic					key4IsPressed,
	input	logic					key6IsPressed,
	output	logic			[7:0]	RGB_flipper,
	output	logic					draw_flipper
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
// output
	.topLeftX(topLeftX),
	.topLeftY(topLeftY)
);

flipper_object flipper_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.PixelX(PixelX),
	.PixelY(PixelY),
	.topLeftX(topLeftX),
	.topLeftY(topLeftY),
// output
	.draw(draw_flipper),
	.RGB(RGB_flipper)
);

endmodule
