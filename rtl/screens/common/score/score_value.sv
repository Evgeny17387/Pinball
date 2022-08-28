import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;
import defines::NUMBER_SPACE;
import defines::SCORE_NUMBERS;

module score_value
#(parameter TOP_LEFT_X, TOP_LEFT_Y)
(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic	[15:0] 	score,
	output	logic			drawNumber,
	output	logic	[7:0]	RGBNumber
);

logic drawSquare2 [SCORE_NUMBERS-1:0];
logic [10:0] offsetXSquare2 [SCORE_NUMBERS-1:0];
logic [10:0] offsetYSquare2 [SCORE_NUMBERS-1:0];

logic insideRectangle;
assign insideRectangle = drawSquare2.or();

genvar i;
generate
    for (i = 0; i < SCORE_NUMBERS; i = i + 1) begin : block_squares_inst
        square #(
                .OBJECT_WIDTH(NUMBER_WIDTH),
                .OBJECT_HEIGHT(NUMBER_HEIGHT),
                .TOP_LEFT_X(TOP_LEFT_X + i * NUMBER_SPACE),
                .TOP_LEFT_Y(TOP_LEFT_Y)
                ) square_inst_0 (
        // input
            .pixelX(pixelX),
            .pixelY(pixelY),
        // output
            .draw(drawSquare2[i]),
            .offsetX(offsetXSquare2[i]),
            .offsetY(offsetYSquare2[i])
        );
    end
endgenerate

logic [10:0] offsetX;
logic [10:0] offsetY;

logic [3:0] digit;

always_comb begin
    offsetX = offsetXSquare2[0];
    offsetY = offsetYSquare2[0];
	digit = score[15:12];

    for (integer i = 1; i < SCORE_NUMBERS; i = i + 1) begin
        if (drawSquare2[i]) begin
            offsetX = offsetXSquare2[i];
            offsetY = offsetYSquare2[i];
			if (i == 1) begin
				digit = score[11:8];
			end
			else if (i == 2) begin
				digit = score[7:4];
			end
			else if (i == 3) begin
				digit = score[3:0];
			end
        end
    end
end

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.number(digit),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

endmodule
