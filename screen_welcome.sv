import defines::COLOR_WHITE;

module screen_welcome(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	output	logic	[7:0]	RGB_screen_welcome
);

logic	[7:0]	RGBWord;
logic 			drawWord;

word word_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawWord(drawWord),
	.RGBWord(RGBWord)
);

assign RGB_screen_welcome = drawWord ? RGBWord : COLOR_WHITE;

endmodule
