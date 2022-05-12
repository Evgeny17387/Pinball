module flipper_controller(
	input	logic					clk,
	input	logic					resetN,
	input	logic					startOfFrame,
	input	logic					key4IsPressed,
	input	logic					key6IsPressed,
	input	logic					pause,
	output	logic signed 	[10:0]	topLeftX,
	output	logic signed	[10:0]	topLeftY,
	output	logic			[31:0]	speedX
);

const int FIXED_POINT_MULTIPLIER	= 64;

const int x_FRAME_SIZE				= 639 * FIXED_POINT_MULTIPLIER;
const int y_FRAME_SIZE				= 479 * FIXED_POINT_MULTIPLIER;

const int INITIAL_X 				= 280;
const int INITIAL_Y 				= 400;

const int Xspeed 					= 250;

int topLeftX_FixedPoint;
int topLeftY_FixedPoint;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		topLeftX_FixedPoint <= INITIAL_X * FIXED_POINT_MULTIPLIER;
		topLeftY_FixedPoint <= INITIAL_Y * FIXED_POINT_MULTIPLIER;
	end

	else begin

		if (!pause) begin

			if (startOfFrame == 1'b1) begin

				if (key6IsPressed) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint + Xspeed;
					speedX <= Xspeed;
				end
				else if (key4IsPressed) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint - Xspeed;
					speedX <= -Xspeed;
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
