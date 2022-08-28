import defines::COLOR_WHITE, defines::COLOR_DEFAULT;
import screen_end::WORD_END_TOP_LEFT_X, screen_end::WORD_END_TOP_LEFT_Y, screen_end::WORD_END_SIZE, screen_end::WORD_END_LETTERS;
import screen_end::WORD_END_2_TOP_LEFT_X, screen_end::WORD_END_2_TOP_LEFT_Y, screen_end::WORD_END_2_SIZE, screen_end::WORD_END_2_LETTERS;
import screen_end::WORD_END_3_TOP_LEFT_X, screen_end::WORD_END_3_TOP_LEFT_Y, screen_end::WORD_END_3_SIZE, screen_end::WORD_END_3_LETTERS;
import screen_end::SCORE_VALUE_TOP_LEFT_X, screen_end::SCORE_VALUE_TOP_LEFT_Y;
import screen_end::SCORE_INDEX_TOP_LEFT_X, screen_end::SCORE_INDEX_TOP_LEFT_Y;
import screen_end::SCORE_ROW_SPACE_Y;
import score::TOP_SCORES_NUM;

module screen_end(
	input	logic				clk,
	input	logic				resetN,
	input	logic		[10:0]	pixelX,
	input	logic		[10:0]	pixelY,
	input	TOP_SCORES			topScores,
	output	logic		[7:0]	RGB_screen_end
);

logic 			drawWord_1;
logic	[7:0]	RGBWord_1;

word #(.TOP_LEFT_X(WORD_END_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_TOP_LEFT_Y), .WORD_SIZE(WORD_END_SIZE), .LETTERS(WORD_END_LETTERS)) word_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_1),
	.RGBWord(RGBWord_1)
);

logic 			drawWord_2;
logic	[7:0]	RGBWord_2;

word #(.TOP_LEFT_X(WORD_END_2_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_2_TOP_LEFT_Y), .WORD_SIZE(WORD_END_2_SIZE), .LETTERS(WORD_END_2_LETTERS)) word_2_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_2),
	.RGBWord(RGBWord_2)
);

logic 			drawIndices[TOP_SCORES_NUM];
logic	[7:0]	RGBIndices[TOP_SCORES_NUM];

genvar i;
generate
    for (i = 0; i < TOP_SCORES_NUM; i = i + 1) begin : block_indices_inst
		number_block #(.TOP_LEFT_X(SCORE_INDEX_TOP_LEFT_X), .TOP_LEFT_Y(SCORE_INDEX_TOP_LEFT_Y + i * SCORE_ROW_SPACE_Y)) number_block_inst_0(
		// input
			.clk(clk),
			.resetN(resetN),
			.pixelX(pixelX),
			.pixelY(pixelY),
			.number(topScores.placeIndex[i]),
		// output
			.drawNumber(drawIndices[i]),
			.RGBNumber(RGBIndices[i])
		);
    end
endgenerate

logic drawIndex;
assign drawIndex = drawIndices.or();

logic [7:0] RGBIndex;

always_comb begin
	RGBIndex = RGBIndices[0];
	for (byte k = 0; k < TOP_SCORES_NUM; k = k + 1) begin
		if (drawIndices[k]) begin
			RGBIndex = RGBIndices[k];
		end
	end
end

logic 			drawScores[TOP_SCORES_NUM];
logic	[7:0]	RGBScores[TOP_SCORES_NUM];

genvar j;
generate
    for (j = 0; j < TOP_SCORES_NUM; j = j + 1) begin : block_values_inst
		score_value #(.TOP_LEFT_X(SCORE_VALUE_TOP_LEFT_X), .TOP_LEFT_Y(SCORE_VALUE_TOP_LEFT_Y + j * SCORE_ROW_SPACE_Y)) score_value_inst_0(
		// input
			.clk(clk),
			.resetN(resetN),
			.pixelX(pixelX),
			.pixelY(pixelY),
			.score(topScores.placeScore[j]),
		// output
			.drawNumber(drawScores[j]),
			.RGBNumber(RGBScores[j])
		);
    end
endgenerate

logic drawScore;
assign drawScore = drawScores.or();

logic [7:0] RGBScore;
always_comb begin
	RGBScore = RGBScores[0];
	for (byte k = 0; k < TOP_SCORES_NUM; k = k + 1) begin
		if (drawScores[k]) begin
			RGBScore = RGBScores[k];
		end
	end
end

logic 			drawWord_3;
logic	[7:0]	RGBWord_3;

word #(.TOP_LEFT_X(WORD_END_3_TOP_LEFT_X), .TOP_LEFT_Y(WORD_END_3_TOP_LEFT_Y), .WORD_SIZE(WORD_END_3_SIZE), .LETTERS(WORD_END_3_LETTERS)) word_3_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.color(COLOR_DEFAULT),
// output
	.drawWord(drawWord_3),
	.RGBWord(RGBWord_3)
);

assign RGB_screen_end = drawWord_1 ? RGBWord_1 : drawWord_2 ? RGBWord_2 : drawWord_3 ? RGBWord_3 : drawIndex ? RGBIndex : drawScore ? RGBScore : COLOR_WHITE;

endmodule
