import defines::LEVEL_STATUS_TOP_LEFT_X, defines::LEVEL_STATUS_TOP_LEFT_Y;

module status_level_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input 	logic 			reset_level,
	output	logic			drawStatusLevel,
	output	logic	[7:0]	RGBStatusLevel
);

assign RGBStatusLevel = reset_level ? 8'b00000011 : 8'b00011100;

square_object #(.OBJECT_WIDTH(15), .OBJECT_HEIGHT(15)) square_object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(LEVEL_STATUS_TOP_LEFT_X),
	.topLeftY(LEVEL_STATUS_TOP_LEFT_Y),
// output
	.draw(drawStatusLevel)
);

endmodule
