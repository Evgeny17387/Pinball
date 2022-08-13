import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;

module Obstacle(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input 	logic 			[3:0] 	scoreNumber,
	output	logic					drawObstacle,
	output	logic			[7:0]	RGBObstacle,
	output 	logic 					drawScoreNumber
);

localparam NUMBERS = 10;
localparam NUMBERS_SPACE = 60;

logic drawSquare [NUMBERS-1:0];
logic [10:0] offsetXSquare [NUMBERS-1:0];
logic [10:0] offsetYSquare [NUMBERS-1:0];

genvar i;
generate
    for (i = 0; i < NUMBERS; i = i + 1) begin : block_squares_inst
        square #(
                .OBJECT_WIDTH(NUMBER_WIDTH),
                .OBJECT_HEIGHT(NUMBER_HEIGHT),
                .TOP_LEFT_X(30 + i * NUMBERS_SPACE),
                .TOP_LEFT_Y(60)
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

logic [3:0] numberToDraw;

logic [10:0] offsetXNumber;
logic [10:0] offsetYNumber;

always_comb begin
    numberToDraw = 0;
    offsetXNumber = offsetXSquare[0];
    offsetYNumber = offsetYSquare[0];

    for (int i = 1; i < NUMBERS; i = i + 1) begin
        if (drawSquare[i]) begin
    		numberToDraw = i;
            offsetXNumber = offsetXSquare[i];
            offsetYNumber = offsetYSquare[i];
        end
    end
end

logic			drawNumber;
logic	[7:0]	RGBNumber;

logic insideRectangle;
assign insideRectangle = drawSquare.or();

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXNumber),
	.offsetY(offsetYNumber),
	.number(numberToDraw),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

assign drawObstacle = drawNumber;

assign RGBObstacle = RGBNumber;

assign drawScoreNumber = drawNumber && (numberToDraw == scoreNumber ? 1'b1 : 1'b0);

endmodule
