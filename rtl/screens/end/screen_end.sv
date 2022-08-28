import defines::COLOR_WHITE, defines::COLOR_DEFAULT;

import screen_end::WORD_END_TOP_LEFT_X, screen_end::WORD_END_TOP_LEFT_Y, screen_end::WORD_END_SIZE, screen_end::WORD_END_LETTERS;
import screen_end::WORD_END_2_TOP_LEFT_X, screen_end::WORD_END_2_TOP_LEFT_Y, screen_end::WORD_END_2_SIZE, screen_end::WORD_END_2_LETTERS;
import screen_end::WORD_END_3_TOP_LEFT_X, screen_end::WORD_END_3_TOP_LEFT_Y, screen_end::WORD_END_3_SIZE, screen_end::WORD_END_3_LETTERS;

import screen_end::SCORE_VALUE_TOP_LEFT_X, screen_end::SCORE_VALUE_TOP_LEFT_Y;
import screen_end::SCORE_INDEX_TOP_LEFT_X, screen_end::SCORE_INDEX_TOP_LEFT_Y;

module screen_end(
	input	logic				clk,
	input	logic				resetN,
	input	logic		[10:0]	pixelX,
	input	logic		[10:0]	pixelY,
	input	TOP_SCORES			topScores,
	output	logic		[7:0]	RGB_screen_end
);

logic 			drawWord_1;
logic	[7:0]	RGBWord_1;

word #(.TOP_LEFT_X(WORD_END_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_TOP_LEFT_Y), .WORD_SIZE(WORD_END_SIZE), .LETTERS(WORD_END_LETTERS)) word_inst(
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

word #(.TOP_LEFT_X(WORD_END_2_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_2_TOP_LEFT_Y), .WORD_SIZE(WORD_END_2_SIZE), .LETTERS(WORD_END_2_LETTERS)) word_2_inst(
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








logic 			drawIndex;
logic	[7:0]	RGBIndex;

number_block #(.TOP_LEFT_X(SCORE_INDEX_TOP_LEFT_X), .TOP_LEFT_Y(SCORE_INDEX_TOP_LEFT_Y)) number_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.number(topScores.place1Score),
// output
	.drawNumber(drawIndex),
	.RGBNumber(RGBIndex)
);

logic 			drawScore;
logic	[7:0]	RGBScore;

score_value #(.TOP_LEFT_X(SCORE_VALUE_TOP_LEFT_X), .TOP_LEFT_Y(SCORE_VALUE_TOP_LEFT_Y)) score_value_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.score(topScores.place1Score),
// output
	.drawNumber(drawScore),
	.RGBNumber(RGBScore)
);









logic 			drawWord_3;
logic	[7:0]	RGBWord_3;

word #(.TOP_LEFT_X(WORD_END_3_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_3_TOP_LEFT_Y), .WORD_SIZE(WORD_END_3_SIZE), .LETTERS(WORD_END_3_LETTERS)) word_3_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_3),
	.RGBWord(RGBWord_3)
);

assign RGB_screen_end = drawWord_1 ? RGBWord_1 : drawWord_2 ? RGBWord_2 : drawWord_3 ? RGBWord_3 : drawIndex ? RGBIndex : drawScore ? RGBScore : COLOR_WHITE;

endmodule
