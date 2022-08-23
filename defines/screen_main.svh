
// Score

parameter logic [10:0] SCREEN_MAIN_SCORE_WIDTH = 32;
parameter logic [10:0] SCREEN_MAIN_SCORE_HEIGHT = 32;

parameter logic [10:0] SCREEN_MAIN_SCORE_TOP_LEFT_X = 250;
parameter logic [10:0] SCREEN_MAIN_SCORE_TOP_LEFT_Y = 5;

parameter logic [10:0] SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_X = 300;
parameter logic [10:0] SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_Y = 5;

parameter byte SCORE_NUMBERS = 4;

// Credits

parameter logic [10:0] SCREEN_MAIN_CREDIT_RADIUS = 25;

parameter byte NUM_CREDITS = 3;

parameter logic [10:0] SCREEN_MAIN_CREDITS_TOP_LEFT_X [NUM_CREDITS-1:0] = '{200, 400, 300};
parameter logic [10:0] SCREEN_MAIN_CREDITS_TOP_LEFT_Y [NUM_CREDITS-1:0] = '{150, 150, 250};

parameter logic [10:0] SCREEN_MAIN_CREDIT_NUMBER_OFFSET_X = 17;
parameter logic [10:0] SCREEN_MAIN_CREDIT_NUMBER_OFFSET_Y = 9;

// Ball

parameter int SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_X = 600;
parameter int SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y = 375;

// Background

const int FRAME_OFFSET_HORIZONTAL = 0;
const int FRAME_OFFSET_TOP = 50;
const int FRAME_OFFSET_BOTTOM = 1;

const int FRAME_SPRING_OFFSET_LEFT = 595;
const int FRAME_SPRING_OFFSET_TOP = 410;

// Spring

parameter logic [10:0] SCREEN_MAIN_SPRING_WIDTH = 32;
parameter logic [10:0] SCREEN_MAIN_SPRING_HEIGHT = 65;

parameter logic [10:0] SCREEN_MAIN_SPRING_TOP_LEFT_X = 600;
parameter logic [10:0] SCREEN_MAIN_SPRING_TOP_LEFT_Y = 410;

localparam SPRING_Y_MARGIN = 25;

// Bumpers

parameter logic [10:0] SCREEN_MAIN_BUMPER_WIDTH = 128;
parameter logic [10:0] SCREEN_MAIN_BUMPER_HEIGHT = 64;

parameter logic [10:0] SCREEN_MAIN_BUMPER_1_ORIENTATION = 0;
parameter logic [10:0] SCREEN_MAIN_BUMPER_1_TOP_LEFT_X = 5;
parameter logic [10:0] SCREEN_MAIN_BUMPER_1_TOP_LEFT_Y = 410;

parameter logic [10:0] SCREEN_MAIN_BUMPER_2_ORIENTATION = 1;
parameter logic [10:0] SCREEN_MAIN_BUMPER_2_TOP_LEFT_X = 460;
parameter logic [10:0] SCREEN_MAIN_BUMPER_2_TOP_LEFT_Y = 410;

parameter logic [10:0] SCREEN_MAIN_BUMPER_3_ORIENTATION = 2;
parameter logic [10:0] SCREEN_MAIN_BUMPER_3_TOP_LEFT_X = 500;
parameter logic [10:0] SCREEN_MAIN_BUMPER_3_TOP_LEFT_Y = 60;

// Life

parameter logic [10:0] LIFE_WIDTH = 32;
parameter logic [10:0] LIFE_HEIGHT = 32;

parameter logic [10:0] LIFE_TOP_LEFT_X = 30;
parameter logic [10:0] LIFE_TOP_LEFT_Y = 5;

localparam LIFE_SPACE = 40;

// Equation

parameter logic [10:0] SCREEN_MAIN_LUCK_SYMBOL_WIDTH = 32;
parameter logic [10:0] SCREEN_MAIN_LUCK_SYMBOL_HEIGHT = 32;

parameter logic [10:0] SCREEN_MAIN_LUCK_SYMBOL_TOP_LEFT_X = 525;
parameter logic [10:0] SCREEN_MAIN_LUCK_SYMBOL_TOP_LEFT_Y = 5;

parameter logic [10:0] SCREEN_MAIN_LUCK_NUMBER_TOP_LEFT_X = 575;
parameter logic [10:0] SCREEN_MAIN_LUCK_NUMBER_TOP_LEFT_Y = 5;
