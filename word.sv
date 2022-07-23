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
logic drawLetter1 [1:0];

logic [10:0] offsetX;
logic [10:0] offsetY;
logic [10:0] offsetX1 [1:0];
logic [10:0] offsetY1 [1:0];

assign letter = drawLetter1[0] ? 0 : 1;

assign drawLetter = drawLetter1[0] || drawLetter1[1];

assign offsetX = drawLetter1[0] ? offsetX1[0] : offsetX1[1];
assign offsetY = drawLetter1[0] ? offsetY1[0] : offsetY1[1];

genvar i;
generate
    for (i = 0; i < 2; i = i + 1) begin : block_squares
        square #(.OBJECT_WIDTH(LETTER_WIDTH), .OBJECT_HEIGHT(LETTER_HEIGHT), .TOP_LEFT_X(200 + i * 50), .TOP_LEFT_Y(5)) square_inst_0(
        // input
            .pixelX(pixelX),
            .pixelY(pixelY),
        // output
            .draw(drawLetter1[i]),
            .offsetX(offsetX1[i]),
            .offsetY(offsetY1[i])
        );
    end
endgenerate

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
