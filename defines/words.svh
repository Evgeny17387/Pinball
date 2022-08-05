
localparam LETTER_SPACE = 50;

// screen welcome

localparam WORD_WELCOME_TOP_LEFT_X = 125;
localparam WORD_WELCOME_TOP_LEFT_Y = 100;
localparam WORD_WELCOME_SIZE = 8;
localparam int WORD_WELCOME_LETTERS[WORD_WELCOME_SIZE-1:0] = '{4, 12, 14, 2, 11, 11, 4, 22};

localparam WORD_WELCOME_2_TOP_LEFT_X = 10;
localparam WORD_WELCOME_2_TOP_LEFT_Y = 300;
localparam WORD_WELCOME_2_SIZE = 7;
localparam int WORD_WELCOME_2_LETTERS[WORD_WELCOME_2_SIZE-1:0] = '{28, 26, 18, 18, 4, 17, 15};

localparam WORD_WELCOME_3_TOP_LEFT_X = 10;
localparam WORD_WELCOME_3_TOP_LEFT_Y = 400;
localparam WORD_WELCOME_3_SIZE = 8;
localparam int WORD_WELCOME_3_LETTERS[WORD_WELCOME_3_SIZE-1:0] = '{19, 17, 0, 19, 18, 26, 14, 19};

// screen end

localparam WORD_END_TOP_LEFT_X = 100;
localparam WORD_END_TOP_LEFT_Y = 200;
localparam WORD_END_SIZE = 9;
localparam int WORD_END_LETTERS[WORD_END_SIZE-1:0] = '{17, 4, 21, 14, 26, 4, 12, 0, 6};
