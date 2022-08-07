import defines::INITIAL_X, defines::INITIAL_Y;
import defines::INITIAL_Y_SPEED;

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
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY
);

const 		int Y_GRAVITY 					= 0;

const 		int FIXED_POINT_MULTIPLIER		= 64;

const 		int x_FRAME_SIZE				= 639 * FIXED_POINT_MULTIPLIER;
const 		int y_FRAME_SIZE				= 479 * FIXED_POINT_MULTIPLIER;

int Xspeed;
int Yspeed;

int topLeftX_FixedPoint;
int topLeftY_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		Yspeed <= INITIAL_Y_SPEED;
		topLeftY_FixedPoint <= INITIAL_Y * FIXED_POINT_MULTIPLIER;
	end 
	else begin

		if (reset_level) begin
			Yspeed <= INITIAL_Y_SPEED * (level + 1);
			topLeftY_FixedPoint <= INITIAL_Y * FIXED_POINT_MULTIPLIER;
		end
		else if (!pause) begin

			if ((collisionSmileyBorderTop && (Yspeed < 0)) || (collisionSmileyFlipper && (Yspeed > 0))) begin
				Yspeed <= -Yspeed;
			end
			else if ((collisionSmileyObstacle && hitEdgeCode[2] && (Yspeed < 0)) || (collisionSmileyObstacle && hitEdgeCode[0] && (Yspeed > 0))) begin
				Yspeed <= -Yspeed;
			end

			if (startOfFrame) begin
				topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;
				Yspeed <= Yspeed + Y_GRAVITY;
			end

		end

	end

end

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		Xspeed <= 0;
		topLeftX_FixedPoint <= INITIAL_X * FIXED_POINT_MULTIPLIER;
	end
	else begin

		if (reset_level) begin
			Xspeed <= 0;
			topLeftX_FixedPoint <= INITIAL_X * FIXED_POINT_MULTIPLIER;
		end
		else if (!pause) begin

			if ((collisionSmileyBorderLeft && (Xspeed < 0)) || (collisionSmileyBorderRight && (Xspeed > 0))) begin
				Xspeed <= -Xspeed;
			end
			else if ((collisionSmileyObstacle && hitEdgeCode[3] && (Xspeed < 0)) || (collisionSmileyObstacle && hitEdgeCode[1] && (Xspeed > 0))) begin
				Xspeed <= -Xspeed;
			end
			else if (collisionSmileyFlipper && (Yspeed > 0)) begin
				Xspeed <= Xspeed + flipperSpeedX;
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
