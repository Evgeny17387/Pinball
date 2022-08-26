import defines::FLIPPER_INITIAL_X;
import defines::FIXED_POINT_MULTIPLIER;

module flipper_single_controller(
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

logic collisionOnMoveRight;
logic collisionOnMoveLeft;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		topLeftX_FixedPoint <= FLIPPER_INITIAL_X * FIXED_POINT_MULTIPLIER;
		speedX <= 0;
		collisionOnMoveRight <= 0;
		collisionOnMoveLeft <= 0;

	end

	else begin

		if (reset_level) begin

			topLeftX_FixedPoint <= FLIPPER_INITIAL_X * FIXED_POINT_MULTIPLIER;
			speedX <= 0;
			collisionOnMoveRight <= 0;
			collisionOnMoveLeft <= 0;

		end
		else if (!pause) begin

			if (startOfFrame) begin

				if (key6IsPressed && !collisionOnMoveRight) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;
					speedX <= XspeedCollisionAdd;
				end
				else if (key4IsPressed && !collisionOnMoveLeft) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint - Xspeed;
					speedX <= -XspeedCollisionAdd;
				end
				else begin
					speedX <= 0;
				end

				collisionOnMoveRight = 1'b0;
				collisionOnMoveLeft = 1'b0;

			end
			else begin
				
				if (collisionFlipperFrame && hitEdgeCode[1])
					collisionOnMoveRight = 1'b1;
				else if (collisionFlipperFrame && hitEdgeCode[3])
					collisionOnMoveLeft = 1'b1;

			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
