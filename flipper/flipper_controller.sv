module flipper_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					startOfFrame,
	input	logic					key4IsPressed,
	input	logic					key6IsPressed,
	input	logic					pause,
	input	logic					reset_level,
	input 	logic 					collisionFlipperBorderLeft,
	input 	logic 					collisionFlipperBorderRight,
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY,
	output	logic			[31:0]	speedX
);

const int FIXED_POINT_MULTIPLIER	= 64;

const int x_FRAME_SIZE				= 639 * FIXED_POINT_MULTIPLIER;
const int y_FRAME_SIZE				= 479 * FIXED_POINT_MULTIPLIER;

const int INITIAL_X 				= 280;
const int INITIAL_Y 				= 400;

const int Xspeed 					= 500;
const int XspeedCollisionAdd		= 100;

int topLeftX_FixedPoint;
int topLeftY_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		topLeftX_FixedPoint <= INITIAL_X * FIXED_POINT_MULTIPLIER;
		topLeftY_FixedPoint <= INITIAL_Y * FIXED_POINT_MULTIPLIER;
		speedX <= 0;

	end

	else begin

		if (reset_level) begin

			topLeftX_FixedPoint <= INITIAL_X * FIXED_POINT_MULTIPLIER;
			topLeftY_FixedPoint <= INITIAL_Y * FIXED_POINT_MULTIPLIER;
			speedX <= 0;

		end
		else if (!pause) begin

			if (startOfFrame == 1'b1) begin

				if (key6IsPressed && !collisionFlipperBorderRight) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;
					speedX <= XspeedCollisionAdd;
				end
				else if (key4IsPressed && !collisionFlipperBorderLeft) begin
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
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
