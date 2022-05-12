module smiley_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					startOfFrame,
	input 	logic					collisionSmileyBorders,
	input 	logic					collisionSmileyFlipper,
	input	logic			[3:0] 	HitEdgeCode,
	input	logic					key5IsPressed,
	input	logic					pause,
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY
);

parameter 	int INITIAL_X 					= 280;
parameter 	int INITIAL_Y 					= 185;

parameter 	int INITIAL_X_SPEED 			= 0;
parameter 	int INITIAL_Y_SPEED 			= 100;

const 		int Y_GRAVITY 					= 0;
const 		int Y_EXTRA 					= 0;

parameter 	int MAX_Y_SPEED 				= 230;

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
	
		if (key5IsPressed) begin

			start <= 1;
		
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

			if (!start && key5IsPressed) begin

				Yspeed <= INITIAL_Y_SPEED;
			
			end
			else if (start) begin

				if ((collisionSmileyBorders && (HitEdgeCode[2] == 1)) && (Yspeed < 0))
					Yspeed <= -Yspeed;

				if ((collisionSmileyBorders && (HitEdgeCode[0] == 1)) && (Yspeed > 0))
					Yspeed <= -Yspeed;

				if (collisionSmileyFlipper && (Yspeed > 0))
					Yspeed <= -Yspeed - Y_EXTRA;

				if (startOfFrame) begin

					topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;

					if (Yspeed < MAX_Y_SPEED)
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

			if (!start && key5IsPressed) begin

				Xspeed <= 0;
			
			end
			else if (start) begin

				if (collisionSmileyBorders && (HitEdgeCode [3] == 1) && (Xspeed < 0))
					Xspeed <= -Xspeed;

				if (collisionSmileyBorders && (HitEdgeCode [1] == 1) && (Xspeed > 0))
					Xspeed <= -Xspeed;

				if (startOfFrame == 1'b1)
					topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;

			end

		end

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
