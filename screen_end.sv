import defines::COLOR_WHITE;

module screen_end(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	output	logic	[7:0]	RGB_screen_end
);

logic	[7:0]	RGBWord;
logic 			drawWord;

word_end word_end_inst(
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
