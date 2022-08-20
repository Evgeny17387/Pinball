import defines::FLIPPER_INITIAL_X, defines::FLIPPER_INITIAL_Y;
import defines::FIXED_POINT_MULTIPLIER;

module flipper_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					startOfFrame,
	input	logic					key4IsPressed,
	input	logic					key6IsPressed,
	input	logic					pause,
	input	logic					reset_level,
	input 	logic 					collisionFlipperFrame,
	input 	logic 			[3:0] 	hitEdgeCode,
	output	logic signed 	[10:0]	topLeftX,
	output	logic			[31:0]	speedX
);

const int XspeedCollisionAdd		= 100;
const int Xspeed					= 500;

int topLeftX_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		topLeftX_FixedPoint <= FLIPPER_INITIAL_X * FIXED_POINT_MULTIPLIER;
		speedX <= 0;

	end

	else begin

		if (reset_level) begin

			topLeftX_FixedPoint <= FLIPPER_INITIAL_X * FIXED_POINT_MULTIPLIER;
			speedX <= 0;

		end
		else if (!pause) begin

			if (startOfFrame) begin

				if (key6IsPressed && !(collisionFlipperFrame && hitEdgeCode[1])) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;
					speedX <= XspeedCollisionAdd;
				end
				else if (key4IsPressed && !(collisionFlipperFrame && hitEdgeCode[3])) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint - Xspeed;
					speedX <= -XspeedCollisionAdd;
				end
				else begin
					speedX <= 0;
				end

			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
