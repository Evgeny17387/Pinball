import defines::SCREEN_MAIN_SPRING_TOP_LEFT_Y;
import defines::INITIAL_Y_SPEED;
import defines::FIXED_POINT_MULTIPLIER;
import defines::SPRING_SPEED;
import defines::FRAME_SIZE_Y;
import defines::SPRING_Y_MARGIN;

module spring_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					key5IsPressed,
	input	logic					startOfFrame,
	output	logic signed	[10:0]	topLeftY
);

int speedY;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		speedY <= 0;
		topLeftY <= SCREEN_MAIN_SPRING_TOP_LEFT_Y;

	end 
	else begin

		if (key5IsPressed) begin
			speedY <= SPRING_SPEED;
		end
		else begin
			speedY <= -SPRING_SPEED;
		end

		if (startOfFrame) begin

			if (topLeftY > FRAME_SIZE_Y - SPRING_Y_MARGIN) begin
				if (speedY < 0)
					topLeftY <= topLeftY + speedY;
			end
			else if (topLeftY < SCREEN_MAIN_SPRING_TOP_LEFT_Y) begin
				if (speedY > 0)
					topLeftY <= topLeftY + speedY;
			end
			else
				topLeftY <= topLeftY + speedY;

		end

	end

end

endmodule
