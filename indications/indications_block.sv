import defines::LIFE_INIT;

module indications_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic	[3:0] 	life,
	output	logic			drawIndications,
	output	logic	[7:0]	RGBIndications
);

life_block #(.LIFE_INIT(LIFE_INIT)) life_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.life(life),
// output
	.drawLife(drawIndications),
	.RGBLife(RGBIndications)
);

endmodule
