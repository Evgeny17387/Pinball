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

`define FIRST_LETTER_TOP_LEFT_X 200
`define FIRST_LETTER_TOP_LEFT_Y 5

logic [0:3] letter;

logic drawLetter;
logic drawLetter1;
logic drawLetter2;

logic [10:0] offsetX;
logic [10:0] offsetY;
logic [10:0] offsetX1;
logic [10:0] offsetY1;
logic [10:0] offsetX2;
logic [10:0] offsetY2;

assign letter = drawLetter1 ? 0 : 1;

assign drawLetter = drawLetter1 || drawLetter2;

assign offsetX = drawLetter1 ? offsetX1 : offsetX2;
assign offsetY = drawLetter1 ? offsetY1 : offsetY2;

square #(.OBJECT_WIDTH(LETTER_WIDTH), .OBJECT_HEIGHT(LETTER_HEIGHT), .TOP_LEFT_X(200), .TOP_LEFT_Y(5)) square_inst_1(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawLetter1),
	.offsetX(offsetX1),
	.offsetY(offsetY1)
);

square #(.OBJECT_WIDTH(LETTER_WIDTH), .OBJECT_HEIGHT(LETTER_HEIGHT), .TOP_LEFT_X(200 + 50), .TOP_LEFT_Y(5)) square_inst_2(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawLetter2),
	.offsetX(offsetX2),
	.offsetY(offsetY2)
);

letter letter_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.letter(letter),
	.drawLetter(drawLetter),
// output
	.drawLetterBitMask(drawWord),
	.RGBLetter(RGBWord)
);

endmodule 
