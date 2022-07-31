package defines;

    `include "defines/dimensions.svh"

    `include "defines/colors.svh"

    `include "defines/background.svh"

    `include "defines/level.svh"

    `include "defines/score.svh"

    `include "defines/life.svh"

    `include "defines/letter.svh"

    parameter logic [10:0]  NUMBER_WIDTH            = 16;
    parameter logic [10:0]  NUMBER_HEIGHT           = 32;

    parameter int           INITIAL_X               = 280;
    parameter int           INITIAL_Y               = 185;

    parameter logic [10:0]  LEVEL_STATUS_TOP_LEFT_X = 550;
    parameter logic [10:0]  LEVEL_STATUS_TOP_LEFT_Y = 50;

endpackage

package defines_ball;

    parameter int           WIDTH                   = 64;
    parameter int           HEIGHT                  = 64;

endpackage
