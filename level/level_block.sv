import defines::LEVEL_LABEL_TOP_LEFT_X, defines::LEVEL_LABEL_TOP_LEFT_Y;
import defines::LEVEL_LABEL_WIDTH, defines::LEVEL_LABEL_HEIGHT;

import defines::LEVEL_NUMBER_TOP_LEFT_X, defines::LEVEL_NUMBER_TOP_LEFT_Y;
import defines::NUMBER_WIDTH, defines::NUMBER_HEIGHT;

module level_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input	logic	[3:0] 	level,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic			drawLevel,
	output	logic	[28:0]	RGBLevel
);

//************************************************************************************************* Label

logic [10:0] 	offsetXLabel;
logic [10:0] 	offsetYLabel;

logic 			insideRectangleLabel;

logic			drawLabel;
logic [28:0]	RGBLabel;

square_object #(.OBJECT_WIDTH(LEVEL_LABEL_WIDTH), .OBJECT_HEIGHT(LEVEL_LABEL_HEIGHT)) square_object_label_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(LEVEL_LABEL_TOP_LEFT_X),
	.topLeftY(LEVEL_LABEL_TOP_LEFT_Y),
// output
	.offsetX(offsetXLabel),
	.offsetY(offsetYLabel),
	.draw(insideRectangleLabel),
);

level_label_bitmap level_label_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXLabel),
	.offsetY(offsetYLabel),
	.insideRectangle(insideRectangleLabel),
// output
	.drawLabel(drawLabel),
	.RGBLabel(RGBLabel)
);

//************************************************************************************************* Number

logic [10:0] 	offsetXNumber;
logic [10:0] 	offsetYNumber;

logic 			insideRectangleNumber;

logic			drawNumber;
logic [28:0]	RGBNumber;

square_object #(.OBJECT_WIDTH(NUMBER_WIDTH), .OBJECT_HEIGHT(NUMBER_HEIGHT)) square_object_number_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(LEVEL_NUMBER_TOP_LEFT_X),
	.topLeftY(LEVEL_NUMBER_TOP_LEFT_Y),
// output
	.offsetX(offsetXNumber),
	.offsetY(offsetYNumber),
	.draw(insideRectangleNumber),
);

number_bitmap number_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.offsetX(offsetXNumber),
	.offsetY(offsetYNumber),
	.number(level),
	.insideRectangle(insideRectangleNumber),
// output
	.drawNumber(drawNumber),
	.RGBNumber(RGBNumber)
);

//************************************************************************************************* Output

assign drawLevel = drawLabel || drawNumber;

assign RGBLevel = drawLabel ? RGBLabel : RGBNumber;

endmodule
