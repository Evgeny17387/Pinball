package defines;

    `include "rtl/defines/dimensions.svh"

    `include "rtl/defines/colors.svh"

    `include "rtl/defines/number.svh"

    `include "rtl/defines/letter.svh"

    `include "rtl/defines/words.svh"

    `include "rtl/defines/life.svh"

    `include "rtl/defines/ball.svh"

    `include "rtl/defines/spring.svh"

    `include "rtl/defines/flipper.svh"

    `include "rtl/defines/bumpers.svh"

    `include "rtl/defines/screen_welcome.svh"
    `include "rtl/defines/screen_main.svh"
    `include "rtl/defines/screen_end.svh"

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
