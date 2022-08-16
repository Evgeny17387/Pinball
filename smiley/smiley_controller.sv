import defines::SCREEN_MAIN_BALL_INITIAL_X, defines::SCREEN_MAIN_BALL_INITIAL_Y;
import defines::FIXED_POINT_MULTIPLIER;
import defines::GRAVITY;

module smiley_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					startOfFrame,
	input 	logic 					collisionSmileyBorderTop,
	input 	logic 					collisionSmileyBorderLeft,
	input 	logic 					collisionSmileyBorderRight,
	input 	logic					collisionSmileyFlipper,
	input	logic					key5IsPressed,
	input	logic					pause,
	input	logic			[31:0]	flipperSpeedX,
	input	logic					reset_level,
	input	logic 					collisionSmileyObstacle,
	input 	logic			[3:0]	hitEdgeCode,
	input	logic 			[3:0]	level,
	input	logic					collisionSmileySpringPulse,
	input	int						springSpeedY,
	input	logic					collisionSmileyBumperPulse,
	input	logic					collisionSmileyFrame,
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY
);

int Xspeed;
int Yspeed;

int topLeftX_FixedPoint;
int topLeftY_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		Yspeed <= 0;
		topLeftY_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_Y * FIXED_POINT_MULTIPLIER;
	end 
	else begin

		if (reset_level) begin
			Yspeed <= 0;
			topLeftY_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_Y * FIXED_POINT_MULTIPLIER;
		end
		else if (!pause) begin

			if (startOfFrame) begin

				topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;
				Yspeed <= Yspeed + GRAVITY;

			end
			else begin

				if ((collisionSmileyBorderTop && (Yspeed < 0)) || (collisionSmileyFlipper && (Yspeed > 0)))
					Yspeed <= -Yspeed;
				else if ((collisionSmileyObstacle && hitEdgeCode[2] && (Yspeed < 0)) || (collisionSmileyObstacle && hitEdgeCode[0] && (Yspeed > 0)))
					Yspeed <= -Yspeed;
				else if (collisionSmileySpringPulse && hitEdgeCode[0]) begin
					if (springSpeedY < 0)
						Yspeed <= Yspeed + springSpeedY;
					else
						Yspeed <= -Yspeed;
				end
				else if (collisionSmileyBumperPulse && (Yspeed < 0))
					Yspeed <= -Yspeed;

			end

		end

	end

end

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		Xspeed <= 0;
		topLeftX_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_X * FIXED_POINT_MULTIPLIER;
	end
	else begin

		if (reset_level) begin
			Xspeed <= 0;
			topLeftX_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_X * FIXED_POINT_MULTIPLIER;
		end
		else if (!pause) begin

			if (startOfFrame == 1'b1)

				topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;

			else begin

				if ((collisionSmileyBorderLeft && (Xspeed < 0)) || (collisionSmileyBorderRight && (Xspeed > 0)))
					Xspeed <= -Xspeed;
				else if ((collisionSmileyObstacle && hitEdgeCode[3] && (Xspeed < 0)) || (collisionSmileyObstacle && hitEdgeCode[1] && (Xspeed > 0)))
					Xspeed <= -Xspeed;
				else if (collisionSmileyFlipper && (Yspeed > 0))
					Xspeed <= Xspeed + flipperSpeedX;
				else if (collisionSmileyBumperPulse && (Yspeed < 0))
					Xspeed <= Yspeed;
				else if (collisionSmileyFrame) begin
					if (hitEdgeCode[1] && (Xspeed > 0))
						Xspeed <= -Xspeed;
					else if (hitEdgeCode[3] && (Xspeed < 0))
						Xspeed <= -Xspeed;
				end

			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
