import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;
import defines::COLOR_WHITE;
import defines::SCREEN_MAIN_CREDIT_RADIUS;
import defines::SCREEN_MAIN_CREDIT_1_TOP_LEFT_X, defines::SCREEN_MAIN_CREDIT_1_TOP_LEFT_Y;
import defines::SCREEN_MAIN_CREDIT_NUMBER_OFFSET_X, defines::SCREEN_MAIN_CREDIT_NUMBER_OFFSET_Y;

module credit_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic			[7:0]	RGBCredit,
	output 	logic 					drawCredit
);

logic drawCicrcle;

circle_dynamic #(.RADIUS(SCREEN_MAIN_CREDIT_RADIUS)) circle_dynamic_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(SCREEN_MAIN_CREDIT_1_TOP_LEFT_X),
	.topLeftY(SCREEN_MAIN_CREDIT_1_TOP_LEFT_Y),
// output
	.draw(drawCicrcle),
);

logic [10:0]	offsetX;
logic [10:0] 	offsetY;
logic 			drawSquare;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(SCREEN_MAIN_CREDIT_1_TOP_LEFT_X + SCREEN_MAIN_CREDIT_NUMBER_OFFSET_X), .TOP_LEFT_Y(SCREEN_MAIN_CREDIT_1_TOP_LEFT_Y + SCREEN_MAIN_CREDIT_NUMBER_OFFSET_Y)) square_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.offsetX(offsetX),
	.offsetY(offsetY),
	.draw(drawSquare),
);

logic			drawNumber;
logic	[10:0]	RGBNumber;

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.number(0),
	.insideRectangle(drawSquare),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

assign drawCredit	= drawCicrcle || drawNumber;
assign RGBCredit	= drawNumber ? RGBNumber : COLOR_WHITE;

endmodule
