import defines::COLOR_TRANSPARENT, defines::COLOR_DEFAULT;
import defines::LETTER_HEIGHT, defines::LETTER_WIDTH;

module word
#(parameter TOP_LEFT_X = 0, TOP_LEFT_Y = 0)
(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawWord,
	output	logic	[7:0]	RGBWord
);

logic drawLetter1;
logic drawLetter2;

assign drawWord = drawLetter1 || drawLetter2;

logic [7:0] RGBLetter1;
logic [7:0] RGBLetter2;

assign RGBWord = drawLetter1 ? RGBLetter1 : RGBLetter2;

letter #(.TOP_LEFT_X(200), .TOP_LEFT_Y(5)) letter_inst1(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.letter(0),
// output
	.drawLetter(drawLetter1),
	.RGBLetter(RGBLetter1)
);

letter #(.TOP_LEFT_X(250), .TOP_LEFT_Y(5)) letter_inst2(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.letter(1),
// output
	.drawLetter(drawLetter2),
	.RGBLetter(RGBLetter2)
);

endmodule 
