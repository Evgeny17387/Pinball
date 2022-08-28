module scores(
	input	logic 			clk,
	input	logic 			resetN,
	input	logic	[3:0]	playerId,
	input	logic	[15:0]	score,
	input	logic			gameEnd,
	output	TOP_SCORES		topScores
);

logic [15:0] scoreCurrent, scoreNext;

assign topScores.place1Score = place1ScoreCurrent;
logic [15:0] place1ScoreCurrent, place1ScoreNext;
assign topScores.place1Index = place1IndexCurrent;
logic [3:0] place1IndexCurrent, place1IndexNext;

assign topScores.place2Score = place2ScoreCurrent;
logic [15:0] place2ScoreCurrent, place2ScoreNext;
assign topScores.place2Index = place2IndexCurrent;
logic [3:0] place2IndexCurrent, place2IndexNext;

assign topScores.place3Score = place3ScoreCurrent;
logic [15:0] place3ScoreCurrent, place3ScoreNext;
assign topScores.place3Index = place3IndexCurrent;
logic [3:0] place3IndexCurrent, place3IndexNext;

always_ff @(posedge clk or negedge resetN) begin

	if (!resetN) begin

		scoreCurrent <= 0;

		place1ScoreCurrent <= 0;
		place1IndexCurrent <= 0;

		place2ScoreCurrent <= 0;
		place2IndexCurrent <= 0;

		place3ScoreCurrent <= 0;
		place3IndexCurrent <= 0;

	end
	else begin

		scoreCurrent <= scoreNext;

		place1ScoreCurrent <= place1ScoreNext;
		place1IndexCurrent <= place1IndexNext;

		place2ScoreCurrent <= place2ScoreNext;
		place2IndexCurrent <= place2IndexNext;

		place3ScoreCurrent <= place3ScoreNext;
		place3IndexCurrent <= place3IndexNext;

	end

end

always_comb begin

	place1ScoreNext = place1ScoreCurrent;
	place1IndexNext = place1IndexCurrent;

	place2ScoreNext = place2ScoreCurrent;
	place2IndexNext = place2IndexCurrent;

	place3ScoreNext = place3ScoreCurrent;
	place3IndexNext = place3IndexCurrent;

	if (gameEnd) begin

		if (scoreCurrent > place1ScoreNext) begin

			place3ScoreNext = place2ScoreCurrent;
			place3IndexNext = place2IndexCurrent;

			place2ScoreNext = place1ScoreCurrent;
			place2IndexNext = place1IndexCurrent;

			place1ScoreNext = scoreCurrent;
			place1IndexNext = playerId;

		end else if (scoreCurrent > place2ScoreNext) begin

			place3ScoreNext = place2ScoreCurrent;
			place3IndexNext = place2IndexCurrent;

			place2ScoreNext = scoreCurrent;
			place2IndexNext = playerId;

		end else if (scoreCurrent > place3ScoreNext) begin

			place3ScoreNext = scoreCurrent;
			place3IndexNext = playerId;

		end


	end

end

always_comb begin

	scoreNext = score;

end

endmodule
