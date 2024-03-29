import defines::COLOR_WHITE, defines::COLOR_DEFAULT;
import defines::WORD_WELCOME_TOP_LEFT_X, defines::WORD_WELCOME_TOP_LEFT_Y, defines::WORD_WELCOME_SIZE, defines::WORD_WELCOME_LETTERS;
import defines::WORD_WELCOME_2_TOP_LEFT_X, defines::WORD_WELCOME_2_TOP_LEFT_Y, defines::WORD_WELCOME_2_SIZE, defines::WORD_WELCOME_2_LETTERS;
import defines::WORD_WELCOME_3_TOP_LEFT_X, defines::WORD_WELCOME_3_TOP_LEFT_Y, defines::WORD_WELCOME_3_SIZE, defines::WORD_WELCOME_3_LETTERS;
import defines::WORD_WELCOME_4_TOP_LEFT_X, defines::WORD_WELCOME_4_TOP_LEFT_Y, defines::WORD_WELCOME_4_SIZE, defines::WORD_WELCOME_4_LETTERS;
import defines::WORD_WELCOME_5_TOP_LEFT_X, defines::WORD_WELCOME_5_TOP_LEFT_Y, defines::WORD_WELCOME_5_SIZE, defines::WORD_WELCOME_5_LETTERS;
import defines::WORD_WELCOME_6_TOP_LEFT_X, defines::WORD_WELCOME_6_TOP_LEFT_Y, defines::WORD_WELCOME_6_SIZE, defines::WORD_WELCOME_6_LETTERS;
import defines::SCREEN_WELCOME_PLAYER_ID_TOP_LEFT_X, defines::SCREEN_WELCOME_PLAYER_ID_TOP_LEFT_Y;

module screen_welcome(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	input	logic 			key2IsPressed,
	input	logic 			key4IsPressed,
	input	logic 			key6IsPressed,
	input	logic 			key8IsPressed,
	input	logic			screenWelcomeOperational,
	input	logic			oneSecPulse,
	output	logic	[7:0]	RGB_screen_welcome,
	output	logic			flipperType,
	output	logic	[3:0]	playerId
);

logic	[7:0]	colorDual;
logic	[7:0]	colorSingle;

screen_welcome_controller screen_welcome_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key2IsPressed(key2IsPressed),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
	.key8IsPressed(key8IsPressed),
	.screenWelcomeOperational(screenWelcomeOperational),
	.oneSecPulse(oneSecPulse),
// output
	.colorSingle(colorSingle),
	.colorDual(colorDual),
	.flipperType(flipperType),
	.playerId(playerId)
);

logic 			drawWord_1;
logic	[7:0]	RGBWord_1;

word #(.TOP_LEFT_X(WORD_WELCOME_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_SIZE), .LETTERS(WORD_WELCOME_LETTERS)) word_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_1),
	.RGBWord(RGBWord_1)
);

logic 			drawWord_2;
logic	[7:0]	RGBWord_2;

word #(.TOP_LEFT_X(WORD_WELCOME_2_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_2_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_2_SIZE), .LETTERS(WORD_WELCOME_2_LETTERS)) word_2_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_2),
	.RGBWord(RGBWord_2)
);

logic 			drawWord_3;
logic	[7:0]	RGBWord_3;

word #(.TOP_LEFT_X(WORD_WELCOME_3_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_3_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_3_SIZE), .LETTERS(WORD_WELCOME_3_LETTERS)) word_3_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(colorSingle),
// output
	.drawWord(drawWord_3),
	.RGBWord(RGBWord_3)
);

logic 			drawWord_4;
logic	[7:0]	RGBWord_4;

word #(.TOP_LEFT_X(WORD_WELCOME_4_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_4_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_4_SIZE), .LETTERS(WORD_WELCOME_4_LETTERS)) word_4_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(colorDual),
// output
	.drawWord(drawWord_4),
	.RGBWord(RGBWord_4)
);

logic 			drawWord_5;
logic	[7:0]	RGBWord_5;

word #(.TOP_LEFT_X(WORD_WELCOME_5_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_5_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_5_SIZE), .LETTERS(WORD_WELCOME_5_LETTERS)) word_5_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_5),
	.RGBWord(RGBWord_5)
);

logic 			drawPlayerId;
logic	[7:0]	RGBPlayerId;

number_block #(.TOP_LEFT_X(SCREEN_WELCOME_PLAYER_ID_TOP_LEFT_X), .TOP_LEFT_Y(SCREEN_WELCOME_PLAYER_ID_TOP_LEFT_Y)) number_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.number(playerId),
// output
	.drawNumber(drawPlayerId),
	.RGBNumber(RGBPlayerId)
);

logic 			drawWord_6;
logic	[7:0]	RGBWord_6;

word #(.TOP_LEFT_X(WORD_WELCOME_6_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_6_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_6_SIZE), .LETTERS(WORD_WELCOME_6_LETTERS)) word_6_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_6),
	.RGBWord(RGBWord_6)
);

assign RGB_screen_welcome = drawWord_1 ? RGBWord_1 : drawWord_2 ? RGBWord_2 : drawWord_3 ? RGBWord_3 : drawWord_4 ? RGBWord_4 : drawWord_5 ? RGBWord_5 : drawWord_6 ? RGBWord_6 : drawPlayerId ? RGBPlayerId : COLOR_WHITE;

endmodule
