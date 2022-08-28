
typedef struct packed {
	logic signed [3:0] xxFactor;
	logic signed [3:0] xyFactor;
	logic signed [3:0] yyFactor;
	logic signed [3:0] yxFactor;
} COLLISION_FACTOR;

typedef struct packed {
	logic	[15:0]	place1Score;
	logic	[3:0]	place1Index;
	logic	[15:0]	place2Score;
	logic	[3:0]	place2Index;
	logic	[15:0]	place3Score;
	logic	[3:0]	place3Index;
} TOP_SCORES;
