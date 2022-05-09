module main(
	output	logic [28:0] 	OVGA,
	input		logic				resetN,
	input		logic				CLOCK_50,
	input		logic	[3:1]		KEY
);

logic				clk;
logic				reset;

logic	[10:0]	PixelX;
logic	[10:0]	PixelY;

logic	[7:0]		RGB_backGround;
logic	[7:0]		RGB_smiley;
logic	[7:0]		RGB;

logic				draw_boarders;
logic 			draw_smiley;

logic 			startOfFrame;
logic 			Y_direction;
logic				toggleX;
logic				collision;

assign reset = !resetN;

assign Y_direction	= KEY[1];
assign toggleX 		= KEY[2];

back_ground_draw back_ground_draw_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.PixelX(PixelX),
	.PixelY(PixelY),
// output
	.RGB_backGround(RGB_backGround),
	.draw_boarders(draw_boarders)
);

smiley_block smiley_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.PixelX(PixelX),
	.PixelY(PixelY),
	.startOfFrame(startOfFrame),
	.Y_direction(Y_direction),
	.toggleX(toggleX),
	.collision(collision),
// output
	.RGB_smiley(RGB_smiley),
	.draw_smiley(draw_smiley)
);

objects_mux objects_mux_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.draw_smiley(draw_smiley),
	.RGB_smiley(RGB_smiley),
	.RGB_backGround(RGB_backGround),
// output
	.RGB(RGB)
);

clock_divider_0002 clock_divider_inst(
	.refclk(CLOCK_50),
	.rst(reset),
	.outclk_0(clk),
);

VGA_Controller VGA_Controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.RGBIn(RGB),
// output
	.PixelX(PixelX),
	.PixelY(PixelY),
	.oVGA(OVGA),
	.startOfFrame(startOfFrame)
);

game_controller game_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.draw_smiley(draw_smiley),
	.draw_boarders(draw_boarders),
// output
	.collision(collision)
);

endmodule
