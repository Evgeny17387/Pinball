import defines::SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_X, defines::SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y;
import defines::FIXED_POINT_MULTIPLIER;
import defines::GRAVITY;

module ball_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					startOfFrame,
	input 	logic					collisionBallFlipper,
	input	logic					key5IsPressed,
	input	logic					pause,
	input	logic			[31:0]	flipperSpeedX,
	input	logic					reset_level,
	input	logic 					collisionBallObstacle,
	input 	logic			[3:0]	hitEdgeCode,
	input	logic					collisionBallSpring,
	input	int						springSpeedY,
	input	logic					collisionBallBumper,
	input	logic					collisionBallFrame,
	input	COLLISION_FACTOR		collisionFactor,
	input	logic					collisionBallCredit,
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

byte collisionsCounterBumper;
byte collisionsCounterSpring;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		Yspeed <= 0;
		topLeftY_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y * FIXED_POINT_MULTIPLIER;
		
		collisionsCounterBumper <= 0;
		collisionsCounterSpring <= 0;

	end 
	else begin

		if (reset_level) begin

			Yspeed <= 0;
			topLeftY_FixedPoint <= SCREEN_MAIN_BALL_INITIAL_TOP_LEFT_Y * FIXED_POINT_MULTIPLIER;

			collisionsCounterBumper <= 0;
			collisionsCounterSpring <= 0;

		end
		else if (!pause) begin

			if (startOfFrame) begin

				Yspeed <= Yspeed + GRAVITY;
				topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;

				if (collisionsCounterBumper > 0)
					collisionsCounterBumper <= collisionsCounterBumper - 1;

				if (collisionsCounterSpring > 0)
					collisionsCounterSpring <= collisionsCounterSpring - 1;

			end
			else begin

				if (collisionBallFrame || collisionBallObstacle) begin
					if (hitEdgeCode[2] && (Yspeed < 0))
						Yspeed <= -Yspeed;
					else if (hitEdgeCode[0] && (Yspeed > 0))
						Yspeed <= -Yspeed;
				end
				else if ((collisionsCounterSpring == 0) && collisionBallSpring) begin
					if (hitEdgeCode[0]) begin
						if (springSpeedY < 0) begin
							Yspeed <= -Yspeed + springSpeedY;
						end
						else begin
							Yspeed <= -Yspeed;
						end
						collisionsCounterSpring <= 5;
					end
				end
				else if (collisionBallFlipper) begin
					if (hitEdgeCode[0] && (Yspeed > 0))
						Yspeed <= -Yspeed;
				end
				else if (collisionBallBumper && (collisionsCounterBumper == 0)) begin
					Yspeed <= (Yspeed * collisionFactor.yyFactor + Xspeed * collisionFactor.xyFactor) >>> 1;
					collisionsCounterBumper <= 40;
				end
				else if (collisionBallCredit) begin
					if (hitEdgeCode[2] && (Yspeed < 0)) begin
						Yspeed <= -Yspeed;
					end
					else if (hitEdgeCode[0] && (Yspeed > 0)) begin
						Yspeed <= -Yspeed;
					end
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

			if (startOfFrame == 1'b1) begin

				if (topLeftX_FixedPoint + Xspeed < 0)
					Xspeed <= Xspeed >>> 1;
				else
					topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;

			end
			else begin

				if (collisionBallFrame || collisionBallObstacle) begin
					if (hitEdgeCode[3] && (Xspeed < 0))
						Xspeed <= -Xspeed;
					else if (hitEdgeCode[1] && (Xspeed > 0))
						Xspeed <= -Xspeed;
				end
				else if (collisionBallFlipper) begin
					if (hitEdgeCode[0] && (Yspeed > 0))
						Xspeed <= Xspeed + flipperSpeedX;
				end
				else if (collisionBallBumper && (collisionsCounterBumper == 0)) begin
					Xspeed <= (Xspeed * collisionFactor.xxFactor + Yspeed * collisionFactor.yxFactor) >>> 1;
				end
				else if (collisionBallCredit) begin
					if (hitEdgeCode[3] && (Xspeed < 0)) begin
						Xspeed <= -Xspeed;
					end
					else if (hitEdgeCode[1] && (Xspeed > 0)) begin
						Xspeed <= -Xspeed;
					end
				end

			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
