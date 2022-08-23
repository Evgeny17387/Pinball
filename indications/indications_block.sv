module indications_block(
	input 	logic 			clk,
	input 	logic 			resetN,
	input 	logic	[10:0]	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic	[3:0] 	life,
	input	logic	[3:0] 	score,
	input	logic	[3:0] 	scoreNumber,
	output	logic			drawIndications,
	output	logic	[7:0]	RGBIndications
);

logic 			drawLife;
logic	[7:0]	RGBLife;

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

logic 			drawScore;
logic	[7:0]	RGBScore;

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

logic 			drawEquation;
logic	[7:0]	RGBEquation;

equation_block equation_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.scoreNumber(scoreNumber),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawEquation(drawEquation),
	.RGBEquation(RGBEquation)
);

assign drawIndications = drawLife || drawScore || drawEquation;
assign RGBIndications = drawLife ? RGBLife : drawScore ? RGBScore : RGBEquation;

endmodule
