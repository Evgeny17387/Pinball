module CollisionDetector(
	input	logic 			clk,
	input	logic 			resetN,
	input 	logic 			startOfFrame,
	input	logic 			draw_smiley,
	input	logic 			drawFrame,
	input	logic 			drawFlipper,
	input	logic 			drawObstacle,
	input	logic 			drawSpring,
	input	logic 			drawBumper,
	input	logic			drawScoreNumber,
	input	logic			drawBottom,
	output 	logic 			collisionSmileyFrame,
	output 	logic 			collisionSmileyFlipper,
	output 	logic 			collisionFlipperFrame,
	output	logic 			collisionSmileyObstacle,
	output	logic 			collisionSmileyObstacleGood,
	output	logic 			collisionSmileyObstacleBad,
	output	logic			collisionSmileySpringPulse,
	output	logic			collisionSmileyBumper,
	output	logic			collisionSmileyBottom
);

edge_dectector edge_dectector_ball_bumper_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.signal(draw_smiley && drawBumper),
// output
	.edgeDetected(collisionSmileyBumper)
);


logic collisionFlipperFrame_c;
assign collisionFlipperFrame_c = drawFlipper && drawFrame;
logic collisionFlipperFrame_d;
assign collisionFlipperFrame = !collisionFlipperFrame_d && collisionFlipperFrame_c;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		collisionFlipperFrame_d <= 0;

	end
	else begin

		if (startOfFrame) begin

			collisionFlipperFrame_d <= 0;

		end
		else begin

			if (collisionFlipperFrame_c) begin

				collisionFlipperFrame_d <= 1;

			end

		end
	end

end

assign collisionSmileyBottom = drawBottom && draw_smiley;

logic collisionSmileyFlipper_c;
assign collisionSmileyFlipper_c = draw_smiley && drawFlipper;
logic collisionSmileyFlipper_d;
assign collisionSmileyFlipper = !collisionSmileyFlipper_d && collisionSmileyFlipper_c;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionSmileyFlipper_d <= 0;
	end
	else begin

		if (startOfFrame)
			collisionSmileyFlipper_d <= 0;

		if (collisionSmileyFlipper_c)
			collisionSmileyFlipper_d <= 1;

	end

end

logic collisionSmileyFrame_c;
assign collisionSmileyFrame_c = draw_smiley && drawFrame;
logic collisionSmileyFrame_d;
assign collisionSmileyFrame = !collisionSmileyFrame_d && collisionSmileyFrame_c;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionSmileyFrame_d <= 0;
	end
	else begin

		if (startOfFrame)
			collisionSmileyFrame_d <= 0;

		if (collisionSmileyFrame_c)
			collisionSmileyFrame_d <= 1;

	end

end

logic collisionSmileySpring;
assign collisionSmileySpring = draw_smiley && drawSpring;
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

logic collisionDetectedInFrame;
assign collisionSmileyObstacle		= draw_smiley && drawObstacle && !collisionDetectedInFrame;
assign collisionSmileyObstacleGood	= collisionSmileyObstacle && drawScoreNumber;
assign collisionSmileyObstacleBad	= collisionSmileyObstacle && !drawScoreNumber;

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

endmodule
