import defines::SCREEN_MAIN_SPRING_TOP_LEFT_Y;
import defines::FIXED_POINT_MULTIPLIER;
import defines::SPRING_SPEED_DOWN, defines::SPRING_SPEED_UP;
import defines::FRAME_SIZE_Y;
import defines::SPRING_Y_MARGIN;
import defines::FIXED_POINT_MULTIPLIER;

module spring_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					key5IsPressed,
	input	logic					startOfFrame,
	output	logic signed	[10:0]	topLeftY,
	output	int						speedY
);

int topLeftY_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		speedY <= 0;
		topLeftY_FixedPoint <= SCREEN_MAIN_SPRING_TOP_LEFT_Y * FIXED_POINT_MULTIPLIER;

	end 
	else begin

		if (key5IsPressed)
			speedY <= SPRING_SPEED_DOWN;
		else if (topLeftY > SCREEN_MAIN_SPRING_TOP_LEFT_Y)
			speedY <= SPRING_SPEED_UP;
		else
			speedY <= 0;

		if (startOfFrame) begin

			if (topLeftY > FRAME_SIZE_Y - SPRING_Y_MARGIN) begin
				if (speedY < 0)
					topLeftY_FixedPoint <= topLeftY_FixedPoint + speedY;
			end
			else if (topLeftY < SCREEN_MAIN_SPRING_TOP_LEFT_Y) begin
				if (speedY > 0)
					topLeftY_FixedPoint <= topLeftY_FixedPoint + speedY;
			end
			else
				topLeftY_FixedPoint <= topLeftY_FixedPoint + speedY;

		end

	end

end

assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
