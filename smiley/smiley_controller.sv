import defines::SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_X, defines::SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y;
import defines::FIXED_POINT_MULTIPLIER;
import defines::GRAVITY;

module smiley_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					startOfFrame,
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
	input	logic					collisionSmileyBumper,
	input	logic					collisionSmileyFrame,
	input	COLLISION_FACTOR		collisionFactor,
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY
);

int Xspeed;
int Yspeed;

int topLeftX_FixedPoint;
int topLeftY_FixedPoint;

// {Left, Top, Right, Bottom}
// Left 	- 3
// Top 		- 2
// Right 	- 1
// Bottom 	- 0

int counter;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		Yspeed <= 0;
		topLeftY_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y * FIXED_POINT_MULTIPLIER;
		
		counter <= 0;

	end 
	else begin

		if (reset_level) begin

			Yspeed <= 0;
			topLeftY_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y * FIXED_POINT_MULTIPLIER;

			counter <= 0;

		end
		else if (!pause) begin

			if (startOfFrame) begin

				Yspeed <= Yspeed + GRAVITY;
				topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;

				if (counter > 0)
					counter <= counter - 1;

			end
			else begin

				if (collisionSmileyFrame || collisionSmileyObstacle) begin
					if (hitEdgeCode[2] && (Yspeed < 0))
						Yspeed <= -Yspeed;
					else if (hitEdgeCode[0] && (Yspeed > 0))
						Yspeed <= -Yspeed;
				end
				else if (collisionSmileySpringPulse) begin
					if (hitEdgeCode[0]) begin
						if (springSpeedY < 0)
							Yspeed <= Yspeed + springSpeedY;
						else
							Yspeed <= -Yspeed;
					end
				end
				else if (collisionSmileyFlipper) begin
					if (hitEdgeCode[0] && (Yspeed > 0))
						Yspeed <= -Yspeed;
				end
				else if ((counter == 0) && collisionSmileyBumper) begin
					Yspeed <= (Yspeed * collisionFactor.yyFactor + Xspeed * collisionFactor.xyFactor) >>> 1;
					counter <= 10;
				end

			end

		end

	end

end

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		Xspeed <= 0;
		topLeftX_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_X * FIXED_POINT_MULTIPLIER;

	end
	else begin

		if (reset_level) begin

			Xspeed <= 0;
			topLeftX_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_X * FIXED_POINT_MULTIPLIER;

		end
		else if (!pause) begin

			if (startOfFrame == 1'b1)

				topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;

			else begin

				if (collisionSmileyFrame || collisionSmileyObstacle) begin
					if (hitEdgeCode[3] && (Xspeed < 0))
						Xspeed <= -Xspeed;
					else if (hitEdgeCode[1] && (Xspeed > 0))
						Xspeed <= -Xspeed;
				end
				else if (collisionSmileyFlipper) begin
					if (hitEdgeCode[0] && (Yspeed > 0))
						Xspeed <= Xspeed + flipperSpeedX;
				end
				else if ((counter == 0) && collisionSmileyBumper) begin
					Xspeed <= (Xspeed * collisionFactor.xxFactor + Yspeed * collisionFactor.yxFactor) >>> 1;
				end

			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
