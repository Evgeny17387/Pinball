import defines::COLOR_WHITE;
import defines::WORD_END_TOP_LEFT_X, defines::WORD_END_TOP_LEFT_Y, defines::WORD_END_SIZE, defines::WORD_END_LETTERS;

module screen_end(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	output	logic	[7:0]	RGB_screen_end
);

logic	[7:0]	RGBWord;
logic 			drawWord;

word #(.TOP_LEFT_X(WORD_END_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_TOP_LEFT_Y), .WORD_SIZE(WORD_END_SIZE), .LETTERS(WORD_END_LETTERS)) word_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawWord(drawWord),
	.RGBWord(RGBWord)
);

assign RGB_screen_end = drawWord ? RGBWord : COLOR_WHITE;

endmodule
