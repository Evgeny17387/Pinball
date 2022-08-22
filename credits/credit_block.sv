import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;
import defines::COLOR_WHITE;

module credit_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic			[7:0]	RGBCredit,
	output 	logic 					drawCredit
);

logic drawCicrcle;

circle_dynamic #(.RADIUS(25)) circle_dynamic_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(200),
	.topLeftY(200),
// output
	.draw(drawCicrcle),
);

logic [10:0]	offsetX;
logic [10:0] 	offsetY;
logic 			drawSquare;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(217), .TOP_LEFT_Y(209)) square_inst(
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
