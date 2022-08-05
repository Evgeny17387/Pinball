import defines::COLOR_WHITE;
import defines::WORD_END_TOP_LEFT_X, defines::WORD_END_TOP_LEFT_Y, defines::WORD_END_SIZE, defines::WORD_END_LETTERS;
import defines::WORD_END_2_TOP_LEFT_X, defines::WORD_END_2_TOP_LEFT_Y, defines::WORD_END_2_SIZE, defines::WORD_END_2_LETTERS;
import defines::SCORE_NUMBER_TOP_LEFT_X, defines::SCORE_NUMBER_TOP_LEFT_Y;

module screen_end(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	input	logic	[3:0] 	score,
	output	logic	[7:0]	RGB_screen_end
);

logic 			drawWord_1;
logic 			drawWord_2;
logic 			drawScore;

logic	[7:0]	RGBWord_1;
logic	[7:0]	RGBWord_2;
logic	[7:0]	RGBScore;

word #(.TOP_LEFT_X(WORD_END_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_TOP_LEFT_Y), .WORD_SIZE(WORD_END_SIZE), .LETTERS(WORD_END_LETTERS)) word_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawWord(drawWord_1),
	.RGBWord(RGBWord_1)
);

word #(.TOP_LEFT_X(WORD_END_2_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_2_TOP_LEFT_Y), .WORD_SIZE(WORD_END_2_SIZE), .LETTERS(WORD_END_2_LETTERS)) word_2_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawWord(drawWord_2),
	.RGBWord(RGBWord_2)
);

number_block #(.TOP_LEFT_X(SCORE_NUMBER_TOP_LEFT_X), .TOP_LEFT_Y(SCORE_NUMBER_TOP_LEFT_Y)) number_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.number(score),
// output
	.drawNumber(drawScore),
	.RGBNumber(RGBScore)
);

assign RGB_screen_end = drawWord_1 ? RGBWord_1 : drawWord_2 ? RGBWord_2 : drawScore ? RGBScore : COLOR_WHITE;

endmodule
