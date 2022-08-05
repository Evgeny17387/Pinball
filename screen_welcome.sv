import defines::COLOR_WHITE;
import defines::WORD_WELCOME_TOP_LEFT_X, defines::WORD_WELCOME_TOP_LEFT_Y, defines::WORD_WELCOME_SIZE, defines::WORD_WELCOME_LETTERS;
import defines::WORD_WELCOME_2_TOP_LEFT_X, defines::WORD_WELCOME_2_TOP_LEFT_Y, defines::WORD_WELCOME_2_SIZE, defines::WORD_WELCOME_2_LETTERS;
import defines::WORD_WELCOME_3_TOP_LEFT_X, defines::WORD_WELCOME_3_TOP_LEFT_Y, defines::WORD_WELCOME_3_SIZE, defines::WORD_WELCOME_3_LETTERS;

module screen_welcome(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	output	logic	[7:0]	RGB_screen_welcome
);

logic	[7:0]	RGBWord_1;
logic	[7:0]	RGBWord_2;
logic	[7:0]	RGBWord_3;
logic 			drawWord_1;
logic 			drawWord_2;
logic 			drawWord_3;

word #(.TOP_LEFT_X(WORD_WELCOME_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_SIZE), .LETTERS(WORD_WELCOME_LETTERS)) word_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawWord(drawWord_1),
	.RGBWord(RGBWord_1)
);

word #(.TOP_LEFT_X(WORD_WELCOME_2_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_2_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_2_SIZE), .LETTERS(WORD_WELCOME_2_LETTERS)) word_2_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawWord(drawWord_2),
	.RGBWord(RGBWord_2)
);

word #(.TOP_LEFT_X(WORD_WELCOME_3_TOP_LEFT_X), .TOP_LEFT_Y(WORD_WELCOME_3_TOP_LEFT_Y), .WORD_SIZE(WORD_WELCOME_3_SIZE), .LETTERS(WORD_WELCOME_3_LETTERS)) word_3_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawWord(drawWord_3),
	.RGBWord(RGBWord_3)
);

assign RGB_screen_welcome = drawWord_1 ? RGBWord_1 : drawWord_2 ? RGBWord_2 : drawWord_3 ? RGBWord_3 : COLOR_WHITE;

endmodule
