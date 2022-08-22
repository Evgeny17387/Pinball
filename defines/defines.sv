package defines;

    `include "defines/dimensions.svh"

    `include "defines/colors.svh"

    `include "defines/background.svh"

    `include "defines/letter.svh"

    `include "defines/words.svh"

    `include "defines/life.svh"

    `include "defines/ball.svh"

    `include "defines/spring.svh"

    `include "defines/flipper.svh"

    `include "defines/bumpers.svh"

    `include "defines/screen_welcome.svh"
    `include "defines/screen_main.svh"
    `include "defines/screen_end.svh"

    parameter logic [10:0]  NUMBER_WIDTH            = 16;
    parameter logic [10:0]  NUMBER_HEIGHT           = 32;

    // {Left, Top, Right, Bottom}
    // Left 	- 3
    // Top 		- 2
    // Right 	- 1
    // Bottom 	- 0
    localparam logic [0:3] [0:3] [3:0] HIT_COLORS = 
    {
        16'hC446,
        16'h8C62,
        16'h8932,
        16'h9113
    };

endpackage

package defines_ball;

    parameter int           WIDTH                   = 64;
    parameter int           HEIGHT                  = 64;

endpackage
