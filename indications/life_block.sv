import defines::LIFE_NUMBER_TOP_LEFT_X, defines::LIFE_NUMBER_TOP_LEFT_Y;

module life_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic	[3:0] 	life,
	output	logic			drawLife,
	output	logic	[7:0]	RGBLife
);

//************************************************************************************************* Number

number_block #(.TOP_LEFT_X(LIFE_NUMBER_TOP_LEFT_X), .TOP_LEFT_Y(LIFE_NUMBER_TOP_LEFT_Y)) number_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.number(life),
// output
	.drawNumber(drawLife),
	.RGBNumber(RGBLife)
);

endmodule
