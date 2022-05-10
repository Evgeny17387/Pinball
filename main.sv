module main(
	output	logic [28:0] 	OVGA,
	input		logic				resetN,
	input		logic				CLOCK_50,
	input 	logic 			PS2_CLK,
	input 	logic 			PS2_DAT,
	output	logic	[6:0]		HEX0,
	output	logic	[6:0]		HEX1,
	output	logic	[1:0]		LEDR
);

logic				clk;
logic				reset;

logic	[10:0]	PixelX;
logic	[10:0]	PixelY;

logic	[7:0]		RGB_backGround;
logic	[7:0]		RGB_smiley;
logic	[7:0]		RGB_flipper;
logic	[7:0]		RGB;

logic				draw_boarders;
logic 			draw_smiley;
logic 			draw_flipper;

logic 			startOfFrame;

logic				collisionSmileyBorders;
logic				collisionSmileyFlipper;

logic				make;
logic				breakk;
logic	[8:0]		key_code;

logic  			key4IsPressed;
logic  			key6IsPressed;

assign reset = !resetN;

assign LEDR[0] = key6IsPressed;
assign LEDR[1] = key4IsPressed;

background background_inst(
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
	.collisionSmileyBorders(collisionSmileyBorders),
	.collisionSmileyFlipper(collisionSmileyFlipper),
// output
	.RGB_smiley(RGB_smiley),
	.draw_smiley(draw_smiley)
);

flipper_block flipper_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.PixelX(PixelX),
	.PixelY(PixelY),
	.startOfFrame(startOfFrame),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
// output
	.RGB_flipper(RGB_flipper),
	.draw_flipper(draw_flipper)
);

objects_mux objects_mux_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.draw_smiley(draw_smiley),
	.RGB_smiley(RGB_smiley),
	.draw_flipper(draw_flipper),
	.RGB_flipper(RGB_flipper),
	.RGB_backGround(RGB_backGround),
// output
	.RGB(RGB)
);

clock_divider clock_divider_inst(
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
	.draw_flipper(draw_flipper),
// output
	.collisionSmileyBorders(collisionSmileyBorders),
	.collisionSmileyFlipper(collisionSmileyFlipper)
);

keyboard keyboard_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.in(PS2_CLK),
	.kbd_dat(PS2_DAT),
// output
	.make(make),
	.breakk(breakk),
	.key_code(key_code)
);

hex_ss hexSS_inst_1(
// input
	.i_dig(key_code[3:0]),
// output
	.o_seg(HEX0)
);

hex_ss hexSS_inst_2(
// input
	.i_dig(key_code[7:4]),
// output
	.o_seg(HEX1)
);

key_decoder #(.KEY_VALUE(9'h06B)) key_decoder_4_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key_code(key_code),
	.make(make),
	.breakk(breakk),
// output
	.keyIsPressed(key4IsPressed)
);

key_decoder #(.KEY_VALUE(9'h074)) key_decoder_6_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key_code(key_code),
	.make(make),
	.breakk(breakk),
// output
	.keyIsPressed(key6IsPressed)
);

endmodule
