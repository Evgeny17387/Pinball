module smiley_controller(
	input		logic							clk,
	input		logic							resetN,
	input		logic							startOfFrame,
	input		logic							Y_direction,
	input		logic							toggleX,
	input 	logic 						collision,
	input		logic				[3:0] 	HitEdgeCode,
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY
);

parameter 	int INITIAL_X 					= 280;
parameter 	int INITIAL_Y 					= 185;
parameter 	int INITIAL_X_SPEED 			= 0;
parameter 	int INITIAL_Y_SPEED 			= 20;
parameter 	int MAX_Y_SPEED 				= 230;
const 		int Y_ACCEL 					= -1;
const 		int FIXED_POINT_MULTIPLIER	= 64;
const 		int x_FRAME_SIZE				= 639 * FIXED_POINT_MULTIPLIER;
const 		int y_FRAME_SIZE				= 479 * FIXED_POINT_MULTIPLIER;
const 		int bracketOffset 			= 30;
const 		int OBJECT_WIDTH_X 			= 64;
				int Xspeed;
				int topLeftX_FixedPoint;
				int Yspeed;
				int topLeftY_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		Yspeed <= INITIAL_Y_SPEED;
		topLeftY_FixedPoint <= INITIAL_Y * FIXED_POINT_MULTIPLIER;
	end 

	else begin

		if (collision && (HitEdgeCode[2] == 1) && (Yspeed < 0))
			Yspeed <= -Yspeed;

		if (collision && (HitEdgeCode[0] == 1) && (Yspeed > 0))
			Yspeed <= -Yspeed;

		if (startOfFrame == 1'b1) begin

			topLeftY_FixedPoint <= topLeftY_FixedPoint + Yspeed;

			if (Yspeed < MAX_Y_SPEED)
				Yspeed <= Yspeed + Y_ACCEL;

			if (Y_direction && (Yspeed > 0))
				Yspeed <= -Yspeed;

		end

	end

end

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		Xspeed <= INITIAL_X_SPEED;
		topLeftX_FixedPoint <= INITIAL_X * FIXED_POINT_MULTIPLIER;
	end

	else begin

		if (toggleX)
			Xspeed <= -Xspeed;

		if (collision && (HitEdgeCode [3] == 1) && (Xspeed < 0))
			Xspeed <= -Xspeed;

		if (collision && (HitEdgeCode [1] == 1) && (Xspeed > 0))
			Xspeed <= -Xspeed;

		if (startOfFrame == 1'b1)
			topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;

	end

end

assign topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER;
assign topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER;

endmodule
