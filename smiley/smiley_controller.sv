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
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY
);

parameter 	int INITIAL_X 					= 280;
parameter 	int INITIAL_Y 					= 185;

parameter 	int INITIAL_X_SPEED 			= 0;
parameter 	int INITIAL_Y_SPEED 			= 100;

const 		int Y_GRAVITY 					= 2;

const 		int FIXED_POINT_MULTIPLIER		= 64;

const 		int x_FRAME_SIZE				= 639 * FIXED_POINT_MULTIPLIER;
const 		int y_FRAME_SIZE				= 479 * FIXED_POINT_MULTIPLIER;

int Xspeed;
int Yspeed;

int topLeftX_FixedPoint;
int topLeftY_FixedPoint;

logic start;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		start <= 0;

	end 

	else begin

		if (!pause) begin

			if (!start) begin

				start <= 1;

			end

		end
	
	end

end

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		Yspeed <= 0;
		topLeftY_FixedPoint <= INITIAL_Y * FIXED_POINT_MULTIPLIER;
	end 

	else begin
	
		if (!pause) begin

			if (!start) begin

				Yspeed <= INITIAL_Y_SPEED;

			end
			else if (start) begin
			
				if (collisionSmileyBorderTop && (Yspeed < 0))
					Yspeed <= -Yspeed;
				else if (collisionSmileyFlipper && (Yspeed > 0))
					Yspeed <= -Yspeed;

				if (startOfFrame) begin

					topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;

					Yspeed <= Yspeed + Y_GRAVITY;

				end
			
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

		if (!pause) begin

			if (!start) begin

				Xspeed <= 0;

			end
			else if (start) begin

				if (collisionSmileyBorderLeft && (Xspeed < 0))
					Xspeed <= -Xspeed;
				else if (collisionSmileyBorderRight && (Xspeed > 0))
					Xspeed <= -Xspeed;
				else if (collisionSmileyFlipper && (Yspeed > 0))
					Xspeed <= Xspeed + flipperSpeedX;

				if (startOfFrame == 1'b1)
					topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;

			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
