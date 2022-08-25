import defines::FLIPPER_DUAL_LEFT_INITIAL_X, defines::FLIPPER_DUAL_RIGHT_INITIAL_X;
import defines::FIXED_POINT_MULTIPLIER;

module flipper_dual_controller(
	input	logic			clk,
	input	logic			resetN,
	input	logic			startOfFrame,
	input	logic			key2IsPressed,
	input	logic			pause,
	input	logic			reset_level,
	output	logic 	[10:0]	topLeftXLeft,
	output	logic	[10:0]	topLeftXRight
);

const int Xspeed					= 500;

int topLeftXLeft_FixedPoint;
int topLeftXRight_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		topLeftXLeft_FixedPoint <= FLIPPER_DUAL_LEFT_INITIAL_X * FIXED_POINT_MULTIPLIER;
		topLeftXRight_FixedPoint <= FLIPPER_DUAL_RIGHT_INITIAL_X * FIXED_POINT_MULTIPLIER;

	end

	else begin

		if (reset_level) begin

			topLeftXLeft_FixedPoint <= FLIPPER_DUAL_LEFT_INITIAL_X * FIXED_POINT_MULTIPLIER;
			topLeftXRight_FixedPoint <= FLIPPER_DUAL_RIGHT_INITIAL_X * FIXED_POINT_MULTIPLIER;

		end
		else if (!pause) begin

			if (startOfFrame) begin

				if (key2IsPressed) begin
					topLeftXLeft_FixedPoint <= topLeftXLeft_FixedPoint + Xspeed;
					topLeftXRight_FixedPoint <= topLeftXRight_FixedPoint - Xspeed;
				end else begin
					if (topLeftXLeft > FLIPPER_DUAL_LEFT_INITIAL_X) begin
						topLeftXLeft_FixedPoint <= topLeftXLeft_FixedPoint - Xspeed;
					end
					if (topLeftXRight < FLIPPER_DUAL_RIGHT_INITIAL_X) begin
						topLeftXRight_FixedPoint <= topLeftXRight_FixedPoint + Xspeed;
					end
				end

			end

		end

	end

end

assign topLeftXLeft = topLeftXLeft_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftXRight = topLeftXRight_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
