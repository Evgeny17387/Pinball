module CollisionDetector(
	input	logic 			clk,
	input	logic 			resetN,
	input	logic 			draw_smiley,
	input	logic 			draw_top_boarder,
	input	logic 			draw_bottom_boarder,
	input	logic 			draw_left_boarder,
	input	logic 			draw_right_boarder,
	input	logic 			drawFrame,
	input	logic 			draw_flipper,
	input	logic 			drawObstacle,
	input	logic 			drawSpring,
	input	logic 			drawBumper,
	input	logic			drawScoreNumber,
	input 	logic 			startOfFrame,
	output	logic 			collisionSmileyBorderTop,
	output	logic 			collisionSmileyBorderBottom,
	output 	logic 			collisionSmileyBorderLeft,
	output 	logic 			collisionSmileyBorderRight,
	output 	logic 			collisionSmileyFrame,
	output 	logic 			collisionSmileyFlipper,
	output 	logic 			collisionFlipperBorderLeft,
	output 	logic 			collisionFlipperBorderRight,
	output	logic 			collisionSmileyObstacle,
	output	logic 			collisionSmileyObstacleGood,
	output	logic 			collisionSmileyObstacleBad,
	output	logic			collisionSmileySpringPulse,
	output	logic			collisionSmileyBumperPulse
);

assign collisionSmileyBorderTop 	= draw_smiley && draw_top_boarder;
assign collisionSmileyBorderBottom	= draw_smiley && draw_bottom_boarder;
assign collisionSmileyBorderLeft 	= draw_smiley && draw_left_boarder;
assign collisionSmileyBorderRight 	= draw_smiley && draw_right_boarder;
assign collisionSmileyFrame 		= draw_smiley && drawFrame;

assign collisionSmileyFlipper 		= draw_smiley && draw_flipper;

assign collisionSmileyObstacle		= draw_smiley && drawObstacle && !collisionDetectedInFrame;
assign collisionSmileyObstacleGood	= collisionSmileyObstacle && drawScoreNumber;
assign collisionSmileyObstacleBad	= collisionSmileyObstacle && !drawScoreNumber;

logic collisionDetectedInFrame;

logic collisionSmileyBumper;
assign collisionSmileyBumper 		= draw_smiley && drawBumper;
logic collisionSmileyBumper_d;
assign collisionSmileyBumperPulse = !collisionSmileyBumper_d && collisionSmileyBumper;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionSmileyBumper_d <= 0;
	end
	else begin

		if (startOfFrame)
			collisionSmileyBumper_d <= 0;

		if (collisionSmileyBumper)
			collisionSmileyBumper_d <= 1;

	end

end

logic collisionSmileySpring;
assign collisionSmileySpring 		= draw_smiley && drawSpring;
logic collisionSmileySpring_d;
assign collisionSmileySpringPulse = !collisionSmileySpring_d && collisionSmileySpring;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionSmileySpring_d <= 0;
	end
	else begin

		if (startOfFrame)
			collisionSmileySpring_d <= 0;

		if (collisionSmileySpring)
			collisionSmileySpring_d <= 1;

	end

end

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionDetectedInFrame <= 0;
	end
	else begin

		if (startOfFrame) begin
			collisionDetectedInFrame <= 0;
		end

		if (draw_smiley && drawObstacle) begin
			collisionDetectedInFrame <= 1;
		end

	end

end

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

	end
	else begin

		if (startOfFrame) begin
			collisionFlipperBorderLeft <= 0;
			collisionFlipperBorderRight <= 0;
		end
		else begin
			if (draw_flipper && draw_left_boarder)
				collisionFlipperBorderLeft <= 1;
			if (draw_flipper && draw_right_boarder)
				collisionFlipperBorderRight <= 1;
		end
	end

end

endmodule
