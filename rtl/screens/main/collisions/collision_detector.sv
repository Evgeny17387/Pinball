module collision_detector(
	input	logic	clk,
	input	logic 	resetN,
	input 	logic 	startOfFrame,
	input	logic 	drawBall,
	input	logic 	drawFrame,
	input	logic 	drawFlipper,
	input	logic 	drawObstacle,
	input	logic 	drawSpring,
	input	logic 	drawBumper,
	input	logic	drawScoreNumber,
	input	logic	drawBottom,
	input	logic	drawCredit,
	input	logic	drawTrap,
	output 	logic 	collisionBallFrame,
	output 	logic 	collisionBallFlipper,
	output 	logic 	collisionFlipperFrame,
	output	logic 	collisionBallObstacle,
	output	logic 	collisionBallObstacleGood,
	output	logic 	collisionBallObstacleBad,
	output	logic	collisionBallSpring,
	output	logic	collisionBallBumper,
	output	logic	collisionBallBottom,
	output	logic	collisionBallCredit,
	output	logic	collisionBallTrap
);

edge_dectector edge_dectector_ball_credit_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.signal(drawBall && drawCredit),
// output
	.edgeDetected(collisionBallCredit)
);

edge_dectector edge_dectector_ball_bumper_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.signal(drawBall && drawBumper),
// output
	.edgeDetected(collisionBallBumper)
);

edge_dectector edge_dectector_ball_spring_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.signal(drawBall && drawSpring),
// output
	.edgeDetected(collisionBallSpring)
);

edge_dectector edge_dectector_ball_trap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.signal(drawBall && drawTrap),
// output
	.edgeDetected(collisionBallTrap)
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

assign collisionBallBottom = drawBottom && drawBall;

logic collisionBallFlipper_c;
assign collisionBallFlipper_c = drawBall && drawFlipper;
logic collisionBallFlipper_d;
assign collisionBallFlipper = !collisionBallFlipper_d && collisionBallFlipper_c;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionBallFlipper_d <= 0;
	end
	else begin

		if (startOfFrame)
			collisionBallFlipper_d <= 0;

		if (collisionBallFlipper_c)
			collisionBallFlipper_d <= 1;

	end

end

logic collisionBallFrame_c;
assign collisionBallFrame_c = drawBall && drawFrame;
logic collisionBallFrame_d;
assign collisionBallFrame = !collisionBallFrame_d && collisionBallFrame_c;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionBallFrame_d <= 0;
	end
	else begin

		if (startOfFrame)
			collisionBallFrame_d <= 0;

		if (collisionBallFrame_c)
			collisionBallFrame_d <= 1;

	end

end

logic collisionDetectedInFrame;
assign collisionBallObstacle		= drawBall && drawObstacle && !collisionDetectedInFrame;
assign collisionBallObstacleGood	= collisionBallObstacle && drawScoreNumber;
assign collisionBallObstacleBad	= collisionBallObstacle && !drawScoreNumber;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		collisionDetectedInFrame <= 0;
	end
	else begin

		if (startOfFrame) begin
			collisionDetectedInFrame <= 0;
		end

		if (drawBall && drawObstacle) begin
			collisionDetectedInFrame <= 1;
		end

	end

end

endmodule
