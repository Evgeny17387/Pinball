module main(
	input	logic			resetN,
	input	logic			CLOCK_50,
	input 	logic 			PS2_CLK,
	input 	logic 			PS2_DAT,
	output	logic	[28:0] 	OVGA
);

logic			clk;
logic			reset;

assign reset = !resetN;

clock_divider clock_divider_inst(
// input
	.refclk(CLOCK_50),
	.rst(reset),
// output
	.outclk_0(clk)
);

logic	[7:0]	RGB;

logic	[10:0]	pixelX;
logic	[10:0]	pixelY;

logic 			startOfFrame;

VGA_Controller VGA_Controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.RGBIn(RGB),
// output
	.pixelX(pixelX),
	.pixelY(pixelY),
	.oVGA(OVGA),
	.startOfFrame(startOfFrame)
);

logic  			key0IsPressed;
logic  			key1IsPressed;
logic 			key4IsPressed;
logic 			key5IsPressed;
logic  			key6IsPressed;

keyboard_block keyboard_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.in(PS2_CLK),
	.kbd_dat(PS2_DAT),
// output
	.key0IsPressed(key0IsPressed),
	.key1IsPressed(key1IsPressed),
	.key4IsPressed(key4IsPressed),
	.key5IsPressed(key5IsPressed),
	.key6IsPressed(key6IsPressed)
);

logic [7:0] RGB_screen_welcome;

screen_welcome screen_welcome_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.RGB_screen_welcome(RGB_screen_welcome)
);

logic 	[7:0] 	RGB_screen_main;
logic 	[3:0] 	life;
logic	[3:0]	score;

screen_main screen_main_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.key4IsPressed(key4IsPressed),
	.key5IsPressed(key5IsPressed),
	.key6IsPressed(key6IsPressed),
	.startOfFrame(startOfFrame),
// output
	.RGB_screen_main(RGB_screen_main),
	.life(life),
	.score(score)
);

logic [7:0] RGB_screen_end;

screen_end screen_end_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.score(score),
// output
	.RGB_screen_end(RGB_screen_end)
);

logic game_end;

screen_controller screen_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key0IsPressed(key0IsPressed),
	.key1IsPressed(key1IsPressed),
	.life(life),
// output
	.start(start),
	.game_end(game_end)
);

objects_mux objects_mux_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.start(start),
	.game_end(game_end),
	.RGB_screen_welcome(RGB_screen_welcome),
	.RGB_screen_main(RGB_screen_main),
	.RGB_screen_end(RGB_screen_end),
// output
	.RGB(RGB)
);

endmodule
