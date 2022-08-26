module screen_main(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	input	logic 			key2IsPressed,
	input	logic 			key4IsPressed,
	input	logic 			key5IsPressed,
	input	logic 			key6IsPressed,
	input	logic 			startOfFrame,
	input	logic 			start,
	input	logic			flipperType,
	output	logic	[7:0]	RGB_screen_main,
	output	logic	[3:0]	life,
	output	logic	[15:0] 	score
);

logic	[7:0]	RGBCredit;
logic 			drawCredit;

credit_block credit_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.collisionBallCredit(collisionBallCredit),
// output
	.RGBCredit(RGBCredit),
	.drawCredit(drawCredit)
);

logic	[7:0]	RGBBall;
logic 			drawBall;

ball_block ball_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.startOfFrame(startOfFrame),
	.collisionBallFlipper(collisionBallFlipper),
	.key5IsPressed(key5IsPressed),
	.pause(pause),
	.flipperSpeedX(flipperSpeedX),
	.reset_level(reset_level),
	.collisionBallObstacle(collisionBallObstacle),
	.collisionBallSpring(collisionBallSpring),
	.springSpeedY(springSpeedY),
	.collisionBallBumper(collisionBallBumper),
	.collisionBallFrame(collisionBallFrame),
	.collisionFactor(collisionFactor),
	.collisionBallCredit(collisionBallCredit),
// output
	.RGBBall(RGBBall),
	.drawBall(drawBall)
);

logic	[7:0]	RGB_flipper;
logic 			drawFlipper;
logic	[31:0]	flipperSpeedX;

flipper_block flipper_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.startOfFrame(startOfFrame),
	.key2IsPressed(key2IsPressed),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
	.pause(pause),
	.reset_level(reset_level),
	.collisionFlipperFrame(collisionFlipperFrame),
	.flipperType(flipperType),
// output
	.RGB_flipper(RGB_flipper),
	.drawFlipper(drawFlipper),
	.speedX(flipperSpeedX)
);

logic [3:0] scoreNumber;
logic 		drawScoreNumber;

random_number random_number_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.getRandomNumber(reset_level_pulse),
// output
	.randomNumber(scoreNumber)
);

logic	[7:0]	RGBObstacle;
logic 			drawObstacle;

Obstacle Obstacle_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.scoreNumber(scoreNumber),
// output
	.drawObstacle(drawObstacle),
	.RGBObstacle(RGBObstacle),
	.drawScoreNumber(drawScoreNumber)
);

logic [7:0] RGB_backGround;
logic 		drawFrame;
logic		drawBottom;

background background_inst(
// input
	.clk(clk),
	.resetN(resetN),//
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.RGB_backGround(RGB_backGround),
	.drawFrame(drawFrame),
	.drawBottom(drawBottom)
);

logic collisionBallFrame;
logic collisionBallFlipper;
logic collisionFlipperFrame;
logic collisionBallObstacle;
logic collisionBallObstacleGood;
logic collisionBallObstacleBad;
logic collisionBallSpring;
logic collisionBallBumper;
logic collisionBallBottom;
logic collisionBallCredit;

collision_detector collision_detector_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.drawBall(drawBall),
	.drawFrame(drawFrame),
	.drawFlipper(drawFlipper),
	.drawObstacle(drawObstacle),
	.drawSpring(drawSpring),
	.drawBumper(drawBumper),
	.drawScoreNumber(drawScoreNumber),
	.drawBottom(drawBottom),
	.drawCredit(drawCredit),
// output
	.collisionBallFrame(collisionBallFrame),
	.collisionBallFlipper(collisionBallFlipper),
	.collisionFlipperFrame(collisionFlipperFrame),
	.collisionBallObstacle(collisionBallObstacle),
	.collisionBallObstacleGood(collisionBallObstacleGood),
	.collisionBallObstacleBad(collisionBallObstacleBad),
	.collisionBallSpring(collisionBallSpring),
	.collisionBallBumper(collisionBallBumper),
	.collisionBallBottom(collisionBallBottom),
	.collisionBallCredit(collisionBallCredit)
);

logic reset_level_pulse;
logic pause;
logic reset_level;

game_controller game_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key5IsPressed(key5IsPressed),
	.collisionBallObstacle(collisionBallObstacle),
	.collisionBallObstacleGood(collisionBallObstacleGood),
	.collisionBallObstacleBad(collisionBallObstacleBad),
	.start(start),
	.collisionBallBottom(collisionBallBottom),
	.collisionBallCredit(collisionBallCredit),
// output
	.pause(pause),
	.reset_level(reset_level),
	.reset_level_pulse(reset_level_pulse),
	.score(score),
	.life(life)
);

logic 			drawSpring;
logic	[7:0]	RGBSpring;
int				springSpeedY;

spring_block spring_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.key5IsPressed(key5IsPressed),
	.startOfFrame(startOfFrame),
	.reset_level(reset_level),
// output
	.drawSpring(drawSpring),
	.RGBSpring(RGBSpring),
	.speedY(springSpeedY)
);

logic 						drawBumper;
logic				[7:0]	RGBBumper;
COLLISION_FACTOR			collisionFactor;

bumpers_block bumpers_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.drawBumper(drawBumper),
	.RGBBumper(RGBBumper),
	.collisionFactor(collisionFactor)
);

logic	[7:0]	RGBIndications;
logic 			drawIndications;

indications_block indications_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.life(life),
	.score(score),
	.scoreNumber(scoreNumber),
// output
	.drawIndications(drawIndications),
	.RGBIndications(RGBIndications)
);

objects_mux_screen_main objects_mux_screen_main_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.drawBall(drawBall),
	.RGBBall(RGBBall),
	.drawFlipper(drawFlipper),
	.RGB_flipper(RGB_flipper),
	.drawObstacle(drawObstacle),
	.RGBObstacle(RGBObstacle),
	.drawIndications(drawIndications),
	.RGBIndications(RGBIndications),
	.drawSpring(drawSpring),
	.RGBSpring(RGBSpring),
	.drawBumper(drawBumper),
	.RGBBumper(RGBBumper),
	.drawCredit(drawCredit),
	.RGBCredit(RGBCredit),
	.RGB_backGround(RGB_backGround),
// output
	.RGB_screen_main(RGB_screen_main)
);

endmodule
