import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;
import defines::COLOR_WHITE;
import defines::SCREEN_MAIN_CREDIT_RADIUS;
import defines::SCREEN_MAIN_CREDITS_TOP_LEFT_X, defines::SCREEN_MAIN_CREDITS_TOP_LEFT_Y;
import defines::SCREEN_MAIN_CREDIT_NUMBER_OFFSET_X, defines::SCREEN_MAIN_CREDIT_NUMBER_OFFSET_Y;
import defines::NUM_CREDITS;

module credit_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic			[7:0]	RGBCredit,
	output 	logic 					drawCredit
);

logic drawCicrcle[NUM_CREDITS];

logic drawCicrcles;
assign drawCicrcles = drawCicrcle.or();

genvar i;
generate
    for (i = 0; i < NUM_CREDITS; i = i + 1) begin : block_circle_dynamic_inst
        circle_dynamic #(.RADIUS(SCREEN_MAIN_CREDIT_RADIUS)) circle_dynamic_inst_0 (
        // input
            .pixelX(pixelX),
            .pixelY(pixelY),
			.topLeftX(SCREEN_MAIN_CREDITS_TOP_LEFT_X[i]),
			.topLeftY(SCREEN_MAIN_CREDITS_TOP_LEFT_Y[i]),
        // output
            .draw(drawCicrcle[i]),
        );
    end
endgenerate

logic [10:0]	offsetXSquare[NUM_CREDITS];
logic [10:0] 	offsetYSquare[NUM_CREDITS];
logic 			drawSquare[NUM_CREDITS];

logic drawSquares;
assign drawSquares = drawSquare.or();

genvar j;
generate
    for (i = 0; i < NUM_CREDITS; i = i + 1) begin : square_inst
		square #(
			.OBJECT_WIDTH(NUMBER_WIDTH),
			.OBJECT_HEIGHT(NUMBER_HEIGHT),
			.TOP_LEFT_X(SCREEN_MAIN_CREDITS_TOP_LEFT_X[i] + SCREEN_MAIN_CREDIT_NUMBER_OFFSET_X),
			.TOP_LEFT_Y(SCREEN_MAIN_CREDITS_TOP_LEFT_Y[i] + SCREEN_MAIN_CREDIT_NUMBER_OFFSET_Y)
			) square_inst(
		// input
			.pixelX(pixelX),
			.pixelY(pixelY),
		// output
			.offsetX(offsetXSquare[i]),
			.offsetY(offsetYSquare[i]),
			.draw(drawSquare[i]),
		);
	end
endgenerate

logic [10:0] offsetXNumber;
logic [10:0] offsetYNumber;

always_comb begin
    offsetXNumber = offsetXSquare[0];
    offsetYNumber = offsetYSquare[0];

    for (byte i = 1; i < NUM_CREDITS; i = i + 1) begin
        if (drawSquare[i]) begin
            offsetXNumber = offsetXSquare[i];
            offsetYNumber = offsetYSquare[i];
        end
    end
end

logic			drawNumber;
logic	[10:0]	RGBNumber;

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXNumber),
	.offsetY(offsetYNumber),
	.number(0),
	.insideRectangle(drawSquares),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

assign drawCredit	= drawCicrcles || drawNumber;
assign RGBCredit	= drawNumber ? RGBNumber : COLOR_WHITE;

endmodule
