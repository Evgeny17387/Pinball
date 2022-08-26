import defines::COLOR_TRANSPARENT;
import defines::FLIPPER_HEIGHT_Y_DIVIDER, defines::FLIPPER_WIDTH_X_DIVIDER;
import defines::FLIPPER_COLOR;
import defines::HIT_COLORS;

module flipper_single_object(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	offsetX,
	input 	logic signed 	[10:0] 	offsetY,
	input	logic					insideBracket,
	output	logic					draw,
	output	logic			[7:0]	RGB,
	output 	logic			[3:0]	hitEdgeCode
);

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
