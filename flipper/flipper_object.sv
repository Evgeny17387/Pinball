import defines::COLOR_TRANSPARENT;
import defines::FLIPPER_HEIGHT_Y_DIVIDER, defines::FLIPPER_WIDTH_X_DIVIDER;
import defines::FLIPPER_COLOR;

module flipper_object(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	offsetX,
	input 	logic signed 	[10:0] 	offsetY,
	input	logic					insideBracket,
	output	logic					draw,
	output	logic			[7:0]	RGB,
	output 	logic			[3:0]	hitEdgeCode
);

// {Left, Top, Right, Bottom}
// Left 	- 3
// Top 		- 2
// Right 	- 1
// Bottom 	- 0
logic [0:3] [0:3] [3:0] HIT_COLORS = 
{
	16'hC446,
	16'h8C62,
	16'h8932,
	16'h9113
};

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		RGB <= 8'b0;
		draw <= 1'b0;
		hitEdgeCode <= 4'h0;

	end

	else begin

		RGB <= COLOR_TRANSPARENT;
		draw <= 1'b0;
		hitEdgeCode <= 4'h0;

		if (insideBracket) begin

			RGB <= FLIPPER_COLOR;
			draw <= 1'b1;
			hitEdgeCode <= HIT_COLORS[offsetY >> FLIPPER_HEIGHT_Y_DIVIDER][offsetX >> FLIPPER_WIDTH_X_DIVIDER];

		end 

	end

end 

endmodule
