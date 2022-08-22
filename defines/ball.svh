
const int GRAVITY = 5;

parameter logic [7:0] BALL_COLOR = COLOR_BLUE_DARK;

localparam logic [10:0] BALL_HEIGHT_NUMBER_OF_Y_BITS = 5;
localparam logic [10:0] BALL_WIDTH_NUMBER_OF_X_BITS = 5;

localparam logic [10:0] BALL_RADIUS = 1 <<  (BALL_HEIGHT_NUMBER_OF_Y_BITS - 1);

localparam logic [10:0] BALL_WIDTH_Y_DIVIDER = BALL_HEIGHT_NUMBER_OF_Y_BITS - 2;
localparam logic [10:0] BALL_WIDTH_X_DIVIDER =  BALL_WIDTH_NUMBER_OF_X_BITS - 2;
