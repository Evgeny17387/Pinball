import defines::BALL_RADIUS;

module ball_block(
	input	logic						clk,
	input	logic						resetN,
	input 	logic				[10:0] 	pixelX,
	input 	logic				[10:0] 	pixelY,
	input 	logic 						startOfFrame,
	input 	logic						collisionBallFlipper,
	input	logic						key5IsPressed,
	input	logic						pause,
	input	logic				[31:0]	flipperSpeedX,
	input	logic						reset_level,
	input	logic 						collisionBallObstacle,
	input	logic						collisionBallSpring,
	input	int							springSpeedY,
	input	logic						collisionBallBumper,
	input	logic						collisionBallFrame,
	input	COLLISION_FACTOR			collisionFactor,
	input	logic						collisionBallCredit,
	output	logic				[7:0]	RGBBall,
	output	logic						drawBall
);

logic [10:0] topLeftX;
logic [10:0] topLeftY;

ball_controller ball_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.collisionBallFlipper(collisionBallFlipper),
	.key5IsPressed(key5IsPressed),
	.pause(pause),
	.flipperSpeedX(flipperSpeedX),
	.reset_level(reset_level),
	.hitEdgeCode(hitEdgeCode),
	.collisionBallObstacle(collisionBallObstacle),
	.collisionBallSpring(collisionBallSpring),
	.springSpeedY(springSpeedY),
	.collisionBallBumper(collisionBallBumper),
	.collisionBallFrame(collisionBallFrame),
	.collisionFactor(collisionFactor),
	.collisionBallCredit(collisionBallCredit),
// output
	.topLeftX(topLeftX),
	.topLeftY(topLeftY)
);

logic draw;
logic [10:0] offsetX;
logic [10:0] offsetY;

circle_dynamic #(.RADIUS(BALL_RADIUS)) circle_dynamic_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.topLeftX(topLeftX),
	.topLeftY(topLeftY),
// output
	.draw(draw),
	.offsetX(offsetX),
	.offsetY(offsetY)
);

logic [3:0] hitEdgeCode;

ball_bitmap ball_bitmap_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.InsideRectangle(draw),
	.offsetX(offsetX),
	.offsetY(offsetY),
// output
	.RGBBall(RGBBall),
	.drawBall(drawBall),
	.hitEdgeCode(hitEdgeCode)
);

endmodule
