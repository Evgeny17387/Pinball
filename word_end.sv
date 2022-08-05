import defines::COLOR_TRANSPARENT, defines::COLOR_DEFAULT;
import defines::LETTER_HEIGHT, defines::LETTER_WIDTH;
import defines::LETTER_SPACE;

module word_end
#(parameter TOP_LEFT_X = 0, TOP_LEFT_Y = 0)
(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawWord,
	output	logic	[7:0]	RGBWord
);

localparam FIRST_LETTER_TOP_LEFT_X = 100;
localparam FIRST_LETTER_TOP_LEFT_Y = 200;
localparam LETTER_SPACE = 50;
localparam WORD_SIZE  = 9;
localparam int letters [WORD_SIZE-1:0]  = '{17, 4, 21, 14, 26, 4, 12, 0, 6};

logic [4:0] letter;

logic drawLetter;
logic drawSquare [WORD_SIZE-1:0];

logic [10:0] offsetXLetter;
logic [10:0] offsetYLetter;
logic [10:0] offsetXSquare [WORD_SIZE-1:0];
logic [10:0] offsetYSquare [WORD_SIZE-1:0];

assign drawLetter = drawSquare.or();

always_comb begin
    letter = letters[0];
    offsetXLetter = offsetXSquare[0];
    offsetYLetter = offsetYSquare[0];

    for (int i = 1; i < WORD_SIZE; i = i + 1) begin
        if (drawSquare[i]) begin
            letter = letters[i];
            offsetXLetter = offsetXSquare[i];
            offsetYLetter = offsetYSquare[i];
        end
    end
end

genvar i;
generate
    for (i = 0; i < WORD_SIZE; i = i + 1) begin : block_squares_inst
        square #(
                .OBJECT_WIDTH(LETTER_WIDTH),
                .OBJECT_HEIGHT(LETTER_HEIGHT),
                .TOP_LEFT_X(FIRST_LETTER_TOP_LEFT_X + i * LETTER_SPACE),
                .TOP_LEFT_Y(FIRST_LETTER_TOP_LEFT_Y)
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
