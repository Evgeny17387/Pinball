import defines::COLOR_TRANSPARENT;
import defines::HIT_COLORS;
import defines::BALL_COLOR;
import defines::BALL_WIDTH_Y_DIVIDER, defines::BALL_WIDTH_X_DIVIDER;

module ball_bitmap(	
	input	logic			clk,
	input	logic			resetN,
	input 	logic	[10:0] 	offsetX,
	input 	logic	[10:0] 	offsetY,
	input	logic			InsideRectangle,
	output	logic			drawBall,
	output	logic	[7:0] 	RGBBall,
	output 	logic	[3:0]	hitEdgeCode
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGBBall <= 8'h00;
		hitEdgeCode <= 4'h0;
	end

	else begin

		RGBBall <= COLOR_TRANSPARENT;
		hitEdgeCode <= 4'h0;

		if (InsideRectangle == 1'b1) begin

			RGBBall <= BALL_COLOR;

			hitEdgeCode <= HIT_COLORS[offsetY >> BALL_WIDTH_Y_DIVIDER][offsetX >> BALL_WIDTH_X_DIVIDER];
		end
	end

end

assign drawBall = (RGBBall != COLOR_TRANSPARENT) ? 1'b1 : 1'b0;

endmodule
