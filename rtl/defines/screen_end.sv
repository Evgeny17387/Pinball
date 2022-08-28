package screen_end;

localparam WORD_END_TOP_LEFT_X = 125;
localparam WORD_END_TOP_LEFT_Y = 50;
localparam WORD_END_SIZE = 9;
localparam int WORD_END_LETTERS[WORD_END_SIZE-1:0] = '{17, 4, 21, 14, 26, 4, 12, 0, 6};

localparam WORD_END_2_TOP_LEFT_X = 10;
localparam WORD_END_2_TOP_LEFT_Y = 150;
localparam WORD_END_2_SIZE = 10;
localparam int WORD_END_2_LETTERS[WORD_END_2_SIZE-1:0] = '{18, 4, 17, 14, 2, 18, 26, 15, 14, 19};

parameter logic [10:0] SCORE_INDEX_TOP_LEFT_X = 10;
parameter logic [10:0] SCORE_INDEX_TOP_LEFT_Y = 250;

parameter logic [10:0] SCORE_VALUE_TOP_LEFT_X = 100;
parameter logic [10:0] SCORE_VALUE_TOP_LEFT_Y = 250;

localparam WORD_END_3_TOP_LEFT_X = 1;
localparam WORD_END_3_TOP_LEFT_Y = 400;
localparam WORD_END_3_SIZE = 16;
localparam int WORD_END_3_LETTERS[WORD_END_3_SIZE-1:0] = '{19, 17, 0, 19, 18, 26, 14, 19, 26, 29, 26, 18, 18, 4, 17, 15};

endpackage
