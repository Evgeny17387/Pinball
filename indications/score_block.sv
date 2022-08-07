import defines::SCREEN_MAIN_SCORE_WIDTH, defines::SCREEN_MAIN_SCORE_HEIGHT;
import defines::SCREEN_MAIN_SCORE_TOP_LEFT_X, defines::SCREEN_MAIN_SCORE_TOP_LEFT_Y;
import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;
import defines::SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_X, defines::SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_Y;

module score_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input	logic	[3:0] 	score,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawScore,
	output	logic	[28:0]	RGBScore
);

logic 			drawSquare;
logic [10:0] 	offsetXSquare;
logic [10:0] 	offsetYSquare;

square #(.OBJECT_WIDTH(SCREEN_MAIN_SCORE_WIDTH), .OBJECT_HEIGHT(SCREEN_MAIN_SCORE_HEIGHT), .TOP_LEFT_X(SCREEN_MAIN_SCORE_TOP_LEFT_X), .TOP_LEFT_Y(SCREEN_MAIN_SCORE_TOP_LEFT_Y)) square_inst_0(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.draw(drawSquare),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare)
);

logic			drawStar;
logic	[7:0]	RGBStar;

score_bitmap score_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXSquare),
	.offsetY(offsetYSquare),
	.insideRectangle(drawSquare),
// output
	.drawStar(drawStar),
	.RGBStar(RGBStar)
);

logic [10:0] 	offsetX;
logic [10:0] 	offsetY;
logic 			insideRectangle;

square #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT), .TOP_LEFT_X(SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_X), .TOP_LEFT_Y(SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_Y)) square_inst_1(
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
	.number(score),
	.insideRectangle(insideRectangle),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

assign drawScore = drawStar || drawNumber;

assign RGBScore = drawStar ? RGBStar : RGBNumber;

endmodule
