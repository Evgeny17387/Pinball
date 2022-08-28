
typedef struct packed {
	logic signed [3:0] xxFactor;
	logic signed [3:0] xyFactor;
	logic signed [3:0] yyFactor;
	logic signed [3:0] yxFactor;
} COLLISION_FACTOR;

typedef struct packed {
	logic	[15:0]	[TOP_SCORES_NUM-1:0]	placeScore;
	logic	[3:0]	[TOP_SCORES_NUM-1:0]	placeIndex;
} TOP_SCORES;
