module indications_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic	[3:0] 	life,
	input	logic	[3:0] 	score,
	input	logic	[3:0] 	level,
	output	logic			drawIndications,
	output	logic	[7:0]	RGBIndications
);

logic 			drawLife;
logic 			drawScore;
logic 			drawLevel;

logic	[7:0]	RGBLife;
logic	[7:0]	RGBScore;
logic	[7:0]	RGBLevel;

life_block life_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.life(life),
// output
	.drawLife(drawLife),
	.RGBLife(RGBLife)
);

score_block score_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.score(score),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawScore(drawScore),
	.RGBScore(RGBScore)
);

level_block level_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.level(level),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawLevel(drawLevel),
	.RGBLevel(RGBLevel)
);

assign drawIndications = drawLife || drawScore || drawLevel;
assign RGBIndications = drawLife ? RGBLife : drawScore ? RGBScore : RGBLevel;

endmodule
