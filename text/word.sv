import defines::COLOR_TRANSPARENT;
import defines::LETTER_HEIGHT, defines::LETTER_WIDTH;
import defines::LETTER_SPACE;

module word
#(parameter TOP_LEFT_X, TOP_LEFT_Y, WORD_SIZE, int LETTERS[WORD_SIZE-1:0])
(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawWord,
	output	logic	[7:0]	RGBWord
);

logic drawLetter;
assign drawLetter = drawSquare.or();

logic drawSquare [WORD_SIZE-1:0];
logic [10:0] offsetXSquare [WORD_SIZE-1:0];
logic [10:0] offsetYSquare [WORD_SIZE-1:0];

genvar i;
generate
    for (i = 0; i < WORD_SIZE; i = i + 1) begin : block_squares_inst
        square #(
                .OBJECT_WIDTH(LETTER_WIDTH),
                .OBJECT_HEIGHT(LETTER_HEIGHT),
                .TOP_LEFT_X(TOP_LEFT_X + i * LETTER_SPACE),
                .TOP_LEFT_Y(TOP_LEFT_Y)
                ) square_inst_0 (
        // input
            .pixelX(pixelX),
            .pixelY(pixelY),
        // output
            .draw(drawSquare[i]),
            .offsetX(offsetXSquare[i]),
            .offsetY(offsetYSquare[i])
        );
    end
endgenerate

logic [4:0] letter;

logic [10:0] offsetXLetter;
logic [10:0] offsetYLetter;

always_comb begin
    letter = LETTERS[0];
    offsetXLetter = offsetXSquare[0];
    offsetYLetter = offsetYSquare[0];

    for (int i = 1; i < WORD_SIZE; i = i + 1) begin
        if (drawSquare[i]) begin
            letter = LETTERS[i];
            offsetXLetter = offsetXSquare[i];
            offsetYLetter = offsetYSquare[i];
        end
    end
end

letter letter_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXLetter),
	.offsetY(offsetYLetter),
	.letter(letter),
	.drawLetter(drawLetter),
// output
	.drawLetterBitMask(drawWord),
	.RGBLetter(RGBWord)
);

endmodule 
