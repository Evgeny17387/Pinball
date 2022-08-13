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

			if ((collisionSmileyBorderTop && (Yspeed < 0)) || (collisionSmileyFlipper && (Yspeed > 0))) begin
				Yspeed <= -Yspeed;
			end
			else if ((collisionSmileyObstacle && hitEdgeCode[2] && (Yspeed < 0)) || (collisionSmileyObstacle && hitEdgeCode[0] && (Yspeed > 0))) begin
				Yspeed <= -Yspeed;
			end
			else if ((collisionSmileyBumperPulse && hitEdgeCode[2] && (Yspeed < 0)) || (collisionSmileyBumperPulse && hitEdgeCode[0] && (Yspeed > 0))) begin
				Yspeed <= -Yspeed;
			end
			else if (collisionSmileySpringPulse && hitEdgeCode[0]) begin
				if (springSpeedY < 0)
					Yspeed <= Yspeed + springSpeedY;
				else
					Yspeed <= -Yspeed;
			end

			if (startOfFrame) begin
				topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;
				Yspeed <= Yspeed + GRAVITY;
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

			if ((collisionSmileyBorderLeft && (Xspeed < 0)) || (collisionSmileyBorderRight && (Xspeed > 0))) begin
				Xspeed <= -Xspeed;
			end
			else if ((collisionSmileyObstacle && hitEdgeCode[3] && (Xspeed < 0)) || (collisionSmileyObstacle && hitEdgeCode[1] && (Xspeed > 0))) begin
				Xspeed <= -Xspeed;
			end
			else if ((collisionSmileyBumperPulse && hitEdgeCode[3] && (Xspeed < 0)) || (collisionSmileyBumperPulse && hitEdgeCode[1] && (Xspeed > 0))) begin
				Xspeed <= -Xspeed;
			end
			else if (collisionSmileyFlipper && (Yspeed > 0)) begin
				Xspeed <= Xspeed + flipperSpeedX;
			end
			else if (collisionSmileyBumperPulse) begin
				Xspeed <= -50;
			end

			if (startOfFrame == 1'b1) begin
				topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;
			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
