module main(
	output	logic	[28:0] 	OVGA,
	input	logic			resetN,
	input	logic			CLOCK_50,
	input 	logic 			PS2_CLK,
	input 	logic 			PS2_DAT,
	output	logic	[6:0]	HEX0,
	output	logic	[6:0]	HEX1,
	output	logic	[6:0]	HEX2,
	output	logic	[1:0]	LEDR
);

logic			clk;
logic			reset;

logic	[10:0]	PixelX;
logic	[10:0]	PixelY;

logic	[7:0]	RGB_backGround;
logic	[7:0]	RGB_smiley;
logic	[7:0]	RGB_flipper;
logic	[7:0]	RGBObstacle;
logic	[7:0]	RGB;

logic			draw_top_boarder;
logic			draw_bottom_boarder;
logic			draw_left_boarder;
logic			draw_right_boarder;
logic 			draw_smiley;
logic 			draw_flipper;
logic 			drawObstacle;

logic 			startOfFrame;

logic			collisionSmileyBorderTop;
logic			collisionSmileyBorderBottom;
logic			collisionSmileyBorderLeft;
logic			collisionSmileyBorderRight;

logic			collisionSmileyFlipper;

logic 			collisionFlipperBorderLeft;
logic 			collisionFlipperBorderRight;

logic 			collisionSmileyObstacle;

logic			pause;
logic			reset_level;

logic			make;
logic			breakk;
logic	[8:0]	key_code;

logic 			key4IsPressed;
logic 			key5IsPressed;
logic  			key6IsPressed;

wire	[31:0]	flipperSpeedX;

logic	[3:0] 	score;

assign reset = !resetN;

assign LEDR[0] = key6IsPressed;
assign LEDR[1] = key4IsPressed;

background background_inst(
// input
	.clk(clk),
	.resetN(resetN),//
	.PixelX(PixelX),
	.PixelY(PixelY),
// output
	.RGB_backGround(RGB_backGround),
	.draw_top_boarder(draw_top_boarder),
	.draw_bottom_boarder(draw_bottom_boarder),
	.draw_left_boarder(draw_left_boarder),
	.draw_right_boarder(draw_right_boarder)
);

smiley_block smiley_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.PixelX(PixelX),
	.PixelY(PixelY),
	.startOfFrame(startOfFrame),
	.collisionSmileyBorderTop(collisionSmileyBorderTop),
	.collisionSmileyBorderLeft(collisionSmileyBorderLeft),
	.collisionSmileyBorderRight(collisionSmileyBorderRight),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.key5IsPressed(key5IsPressed),
	.pause(pause),
	.flipperSpeedX(flipperSpeedX),
	.reset_level(reset_level),
	.collisionSmileyObstacle(collisionSmileyObstacle),
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
	.pause(pause),
	.reset_level(reset_level),
	.collisionFlipperBorderLeft(collisionFlipperBorderLeft),
	.collisionFlipperBorderRight(collisionFlipperBorderRight),
// output
	.RGB_flipper(RGB_flipper),
	.draw_flipper(draw_flipper),
	.speedX(flipperSpeedX)
);

Obstacle Obstacle_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(PixelX),
	.pixelY(PixelY),
// output
	.drawObstacle(drawObstacle),
	.RGBObstacle(RGBObstacle)
);

objects_mux objects_mux_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.draw_smiley(draw_smiley),
	.RGB_smiley(RGB_smiley),
	.draw_flipper(draw_flipper),
	.RGB_flipper(RGB_flipper),
	.drawObstacle(drawObstacle),
	.RGBObstacle(RGBObstacle),
	.RGB_backGround(RGB_backGround),
// output
	.RGB(RGB)
);

clock_divider clock_divider_inst(
	.refclk(CLOCK_50),
	.rst(reset),
	.outclk_0(clk)
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
	.key5IsPressed(key5IsPressed),
	.collisionSmileyBorderBottom(collisionSmileyBorderBottom),
	.collisionSmileyObstacle(collisionSmileyObstacle),
// output
	.pause(pause),
	.reset_level(reset_level),
	.score(score)
);

CollisionDetector CollisionDetector_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.draw_smiley(draw_smiley),
	.draw_top_boarder(draw_top_boarder),
	.draw_bottom_boarder(draw_bottom_boarder),
	.draw_left_boarder(draw_left_boarder),
	.draw_right_boarder(draw_right_boarder),
	.draw_flipper(draw_flipper),
	.drawObstacle(drawObstacle),
	.startOfFrame(startOfFrame),
// output
	.collisionSmileyBorderTop(collisionSmileyBorderTop),
	.collisionSmileyBorderBottom(collisionSmileyBorderBottom),
	.collisionSmileyBorderLeft(collisionSmileyBorderLeft),
	.collisionSmileyBorderRight(collisionSmileyBorderRight),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.collisionFlipperBorderLeft(collisionFlipperBorderLeft),
	.collisionFlipperBorderRight(collisionFlipperBorderRight),
	.collisionSmileyObstacle(collisionSmileyObstacle)
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

hex_ss hexSS_inst_3(
// input
	.i_dig(score[3:0]),
// output
	.o_seg(HEX2)
);

keyboard_block keyboard_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.in(PS2_CLK),
	.kbd_dat(PS2_DAT),
// output
	.key_code(key_code),
	.key4IsPressed(key4IsPressed),
	.key5IsPressed(key5IsPressed),
	.key6IsPressed(key6IsPressed)
);

endmodule
