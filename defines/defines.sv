package defines;

    `include "defines/dimensions.svh"

    `include "defines/colors.svh"

    `include "defines/background.svh"

    `include "defines/letter.svh"

    `include "defines/words.svh"

    `include "defines/life.svh"

    `include "defines/ball.svh"

    `include "defines/spring.svh"

    `include "defines/screen_welcome.svh"
    `include "defines/screen_main.svh"
    `include "defines/screen_end.svh"

    parameter logic [10:0]  NUMBER_WIDTH            = 16;
    parameter logic [10:0]  NUMBER_HEIGHT           = 32;

endpackage

package defines_ball;

    parameter int           WIDTH                   = 64;
    parameter int           HEIGHT                  = 64;

endpackage
