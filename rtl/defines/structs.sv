
typedef struct packed {
	logic signed [3:0] xxFactor;
	logic signed [3:0] xyFactor;
	logic signed [3:0] yyFactor;
	logic signed [3:0] yxFactor;
} COLLISION_FACTOR;

typedef struct packed {
	logic	[TOP_SCORES_NUM-1:0]	[15:0]	placeScore;
	logic	[TOP_SCORES_NUM-1:0]	[3:0]	placeIndex;
} TOP_SCORES;
