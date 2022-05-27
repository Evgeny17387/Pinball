package defines;

    `include "defines/background.svh"

    `include "defines/level.svh"

    `include "defines/score.svh"

    parameter int INITIAL_X = 280;
    parameter int INITIAL_Y = 185;

    parameter logic signed [10:0] LEVEL_STATUS_TOP_LEFT_X = 550;
    parameter logic signed [10:0] LEVEL_STATUS_TOP_LEFT_Y = 50;

endpackage

package defines_ball;

    parameter int WIDTH = 32;
    parameter int HEIGHT = 32;

endpackage
