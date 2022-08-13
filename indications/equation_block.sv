import defines::SCREEN_MAIN_LUCK_SYMBOL_WIDTH, defines::SCREEN_MAIN_LUCK_SYMBOL_HEIGHT;
import defines::SCREEN_MAIN_LUCK_SYMBOL_TOP_LEFT_X, defines::SCREEN_MAIN_LUCK_SYMBOL_TOP_LEFT_Y;
import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;
import defines::SCREEN_MAIN_LUCK_NUMBER_TOP_LEFT_X, defines::SCREEN_MAIN_LUCK_NUMBER_TOP_LEFT_Y;

module equation_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input	logic	[3:0] 	scoreNumber,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawEquation,
	output	logic	[28:0]	RGBEquation
);

logic 			drawSquare;
logic [10:0] 	offsetXSquare;
logic [10:0] 	offsetYSquare;

square #(.OBJECT_WIDTH(SCREEN_MAIN_LUCK_SYMBOL_WIDTH), .OBJECT_HEIGHT(SCREEN_MAIN_LUCK_SYMBOL_HEIGHT), .TOP_LEFT_X(SCREEN_MAIN_LUCK_SYMBOL_TOP_LEFT_X), .TOP_LEFT_Y(SCREEN_MAIN_LUCK_SYMBOL_TOP_LEFT_Y)) square_inst_0(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawSquare),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare)
);

logic			drawLuck;
logic	[7:0]	RGBLuck;

luck_bitmap luck_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare),
	.insideRectangle(drawSquare),
// output
	.drawLuck(drawLuck),
	.RGBLuck(RGBLuck)
);

logic [10:0] 	offsetX;
logic [10:0] 	offsetY;
logic 			insideRectangle;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(SCREEN_MAIN_LUCK_NUMBER_TOP_LEFT_X), .TOP_LEFT_Y(SCREEN_MAIN_LUCK_NUMBER_TOP_LEFT_Y)) square_inst_1(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(insideRectangle),
	.offsetX(offsetX),
	.offsetY(offsetY)
);

logic			drawNumber;
logic	[7:0]	RGBNumber;

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetX),
	.offsetY(offsetY),
	.number(scoreNumber),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

assign drawEquation = drawLuck || drawNumber;

assign RGBEquation = drawLuck ? RGBLuck : RGBNumber;

endmodule
