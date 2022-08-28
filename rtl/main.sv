module main(
	input	logic			resetN,
	input	logic			CLOCK_50,
	input 	logic 			PS2_CLK,
	input 	logic 			PS2_DAT,
	output	logic	[28:0] 	OVGA
);

logic			reset;
assign reset = !resetN;

logic			clk;

clock_divider clock_divider_inst(
// input
	.refclk(CLOCK_50),
	.rst(reset),
// output
	.outclk_0(clk)
);

TOP_SCORES topScores;

scores scores_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.playerId(playerId),
	.score(score),
	.gameEnd(gameEnd),
// output
	.topScores(topScores)
);

logic oneSecPulse;

one_sec_counter one_sec_counter_inst(
// input
	.clk(clk),
	.resetN(resetN),
// output
	.oneSecPulse(oneSecPulse)
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
logic  			key2IsPressed;
logic 			key4IsPressed;
logic 			key5IsPressed;
logic  			key6IsPressed;
logic  			key8IsPressed;
logic  			key9IsPressed;

keyboard_block keyboard_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.in(PS2_CLK),
	.kbd_dat(PS2_DAT),
// output
	.key0IsPressed(key0IsPressed),
	.key1IsPressed(key1IsPressed),
	.key2IsPressed(key2IsPressed),
	.key4IsPressed(key4IsPressed),
	.key5IsPressed(key5IsPressed),
	.key6IsPressed(key6IsPressed),
	.key8IsPressed(key8IsPressed),
	.key9IsPressed(key9IsPressed)
);

logic 	[7:0] 	RGB_screen_welcome;
logic			flipperType;
logic	[3:0]	playerId;

screen_welcome screen_welcome_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.key2IsPressed(key2IsPressed),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
	.key8IsPressed(key8IsPressed),
	.screenWelcomeOperational(screenWelcomeOperational),
	.oneSecPulse(oneSecPulse),
// output
	.RGB_screen_welcome(RGB_screen_welcome),
	.flipperType(flipperType),
	.playerId(playerId)
);

logic 	[7:0] 	RGB_screen_main;
logic 	[3:0] 	life;
logic	[15:0]	score;

screen_main screen_main_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.key2IsPressed(key2IsPressed),
	.key4IsPressed(key4IsPressed),
	.key5IsPressed(key5IsPressed),
	.key6IsPressed(key6IsPressed),
	.startOfFrame(startOfFrame),
	.start(start),
	.flipperType(flipperType),
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
	.topScores(topScores),
// output
	.RGB_screen_end(RGB_screen_end)
);

logic gameEnd;
logic start;
logic screenWelcomeOperational;

screen_controller screen_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key0IsPressed(key0IsPressed),
	.key1IsPressed(key1IsPressed),
	.life(life),
// output
	.start(start),
	.gameEnd(gameEnd),
	.screenWelcomeOperational(screenWelcomeOperational)
);

screen_objects_mux screen_objects_mux_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.start(start),
	.gameEnd(gameEnd),
	.RGB_screen_welcome(RGB_screen_welcome),
	.RGB_screen_main(RGB_screen_main),
	.RGB_screen_end(RGB_screen_end),
// output
	.RGB(RGB)
);

endmodule
