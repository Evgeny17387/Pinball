
// Screen

const int FRAME_SIZE_X = 635;
const int FRAME_SIZE_Y = 475;

// Trap

localparam logic [10:0] SCREEN_MAIN_TRAP_RADIUS_OUTER = 25;
localparam logic [10:0] SCREEN_MAIN_TRAP_RADIUS_INNER = 20;

localparam logic [10:0] SCREEN_MAIN_TRAP_INITIAL_CENTER_X = 100;
localparam logic [10:0] SCREEN_MAIN_TRAP_INITIAL_CENTER_Y = 100;

// Flipper

const int FLIPPER_INITIAL_X = 280;
const int FLIPPER_INITIAL_Y = 440;

localparam logic [10:0] SCREEN_MAIN_FLIPPER_SINGLE_X_LIMIT_LEFT = 5;
localparam logic [10:0] SCREEN_MAIN_FLIPPER_SINGLE_X_LIMIT_RIGHT = 460;

localparam int FLIPPER_NUMBER_OF_Y_BITS = 5;
localparam int FLIPPER_NUMBER_OF_X_BITS = 7;

localparam int FLIPPER_HEIGHT_Y = 1 << FLIPPER_NUMBER_OF_Y_BITS;
localparam int FLIPPER_WIDTH_X = 1 << FLIPPER_NUMBER_OF_X_BITS;

localparam int FLIPPER_HEIGHT_Y_DIVIDER = FLIPPER_NUMBER_OF_Y_BITS - 2;
localparam int FLIPPER_WIDTH_X_DIVIDER = FLIPPER_NUMBER_OF_X_BITS - 2;

const int FLIPPER_DUAL_LEFT_INITIAL_X = 5;
const int FLIPPER_DUAL_RIGHT_INITIAL_X = 460;

const int FLIPPER_DUAL_LEFT_LIMIT_X = 140;
const int FLIPPER_DUAL_RIGHT_LIMIT_X = 330;

// Score

parameter logic [10:0] SCREEN_MAIN_SCORE_WIDTH = 32;
parameter logic [10:0] SCREEN_MAIN_SCORE_HEIGHT = 32;

parameter logic [10:0] SCREEN_MAIN_SCORE_TOP_LEFT_X = 250;
parameter logic [10:0] SCREEN_MAIN_SCORE_TOP_LEFT_Y = 5;

parameter logic [10:0] SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_X = 300;
parameter logic [10:0] SCREEN_MAIN_SCORE_NUMBER_TOP_LEFT_Y = 5;

parameter byte SCORE_NUMBERS = 4;

parameter logic [10:0] NUMBER_SPACE = 20;

// Credits

parameter logic [10:0] SCREEN_MAIN_CREDIT_RADIUS = 25;

parameter byte NUM_CREDITS = 3;

parameter logic [10:0] SCREEN_MAIN_CREDITS_TOP_LEFT_X [NUM_CREDITS-1:0] = '{200, 400, 300};
parameter logic [10:0] SCREEN_MAIN_CREDITS_TOP_LEFT_Y [NUM_CREDITS-1:0] = '{150, 150, 250};

parameter logic [10:0] SCREEN_MAIN_CREDIT_NUMBER_OFFSET_X = 17;
parameter logic [10:0] SCREEN_MAIN_CREDIT_NUMBER_OFFSET_Y = 9;

// Ball

parameter int SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_X = 600;
parameter int SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y = 340;

// Background

const int FRAME_OFFSET_HORIZONTAL = 0;
const int FRAME_OFFSET_TOP = 50;
const int FRAME_OFFSET_BOTTOM = 1;

const int FRAME_SPRING_OFFSET_LEFT = 595;
const int FRAME_SPRING_OFFSET_TOP = 375;

// Spring

parameter logic [10:0] SCREEN_MAIN_SPRING_WIDTH = 32;
parameter logic [10:0] SCREEN_MAIN_SPRING_HEIGHT = 100;

parameter logic [10:0] SCREEN_MAIN_SPRING_TOP_LEFT_X = 600;
parameter logic [10:0] SCREEN_MAIN_SPRING_TOP_LEFT_Y = 375;

localparam SPRING_Y_MARGIN = 25;

// Bumpers

parameter logic [10:0] SCREEN_MAIN_BUMPER_WIDTH = 128;
parameter logic [10:0] SCREEN_MAIN_BUMPER_HEIGHT = 64;

parameter byte NUM_BUMPERS = 3;

parameter logic [10:0] SCREEN_MAIN_BUMPERS_ORIENTATION[NUM_BUMPERS-1:0] = '{2, 1, 0};
parameter logic [10:0] SCREEN_MAIN_BUMPERS_TOP_LEFT_X[NUM_BUMPERS-1:0] = '{500, 460, 5};
parameter logic [10:0] SCREEN_MAIN_BUMPERS_TOP_LEFT_Y[NUM_BUMPERS-1:0] = '{60, 375, 375};

parameter COLLISION_FACTOR SCREEN_MAIN_BUMPERS_COLLISION_FACTOR[NUM_BUMPERS-1:0] = '{
    '{xxFactor: 0,  xyFactor: 2,    yyFactor: 0,    yxFactor: 2},
    '{xxFactor: 0,  xyFactor: -2,   yyFactor: 0,    yxFactor: -2},
    '{xxFactor: 0,  xyFactor: 2,    yyFactor: 0,    yxFactor: 2}
};

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
