module screen_main(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	input	logic 			key4IsPressed,
	input	logic 			key5IsPressed,
	input	logic 			key6IsPressed,
	input	logic 			startOfFrame,
	input	logic 			start,
	output	logic	[7:0]	RGB_screen_main,
	output	logic	[3:0]	life,
	output	logic	[3:0] 	score
);

logic	[7:0]	RGB_flipper;
logic	[7:0]	RGBObstacle;
logic	[7:0]	RGBIndications;

logic 			drawFlipper;
logic 			drawObstacle;
logic 			drawIndications;

logic			pause;
logic			reset_level;

logic	[31:0]	flipperSpeedX;

logic	[3:0] 	level;

logic	[7:0]	RGB_smiley;
logic 			draw_smiley;

smiley_block smiley_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.startOfFrame(startOfFrame),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.key5IsPressed(key5IsPressed),
	.pause(pause),
	.flipperSpeedX(flipperSpeedX),
	.reset_level(reset_level),
	.collisionSmileyObstacle(collisionSmileyObstacle),
	.level(level),
	.collisionSmileySpringPulse(collisionSmileySpringPulse),
	.springSpeedY(springSpeedY),
	.collisionSmileyBumper(collisionSmileyBumper),
	.collisionSmileyFrame(collisionSmileyFrame),
	.collisionFactor(collisionFactor),
// output
	.RGB_smiley(RGB_smiley),
	.draw_smiley(draw_smiley)
);

flipper_block flipper_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.startOfFrame(startOfFrame),
	.key4IsPressed(key4IsPressed),
	.key6IsPressed(key6IsPressed),
	.pause(pause),
	.reset_level(reset_level),
	.collisionFlipperFrame(collisionFlipperFrame),
// output
	.RGB_flipper(RGB_flipper),
	.drawFlipper(drawFlipper),
	.speedX(flipperSpeedX)
);

logic [3:0] scoreNumber;

random_number random_number_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.getRandomNumber(reset_level_pulse),
// output
	.randomNumber(scoreNumber)
);

logic drawScoreNumber;

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

logic collisionSmileyFrame;
logic collisionSmileyFlipper;
logic collisionFlipperFrame;
logic collisionSmileyObstacle;
logic collisionSmileyObstacleGood;
logic collisionSmileyObstacleBad;
logic collisionSmileySpringPulse;
logic collisionSmileyBumper;
logic collisionSmileyBottom;

CollisionDetector CollisionDetector_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.draw_smiley(draw_smiley),
	.drawFrame(drawFrame),
	.drawFlipper(drawFlipper),
	.drawObstacle(drawObstacle),
	.drawSpring(drawSpring),
	.drawBumper(drawBumper),
	.drawScoreNumber(drawScoreNumber),
	.drawBottom(drawBottom),
// output
	.collisionSmileyFrame(collisionSmileyFrame),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.collisionFlipperFrame(collisionFlipperFrame),
	.collisionSmileyObstacle(collisionSmileyObstacle),
	.collisionSmileyObstacleGood(collisionSmileyObstacleGood),
	.collisionSmileyObstacleBad(collisionSmileyObstacleBad),
	.collisionSmileySpringPulse(collisionSmileySpringPulse),
	.collisionSmileyBumper(collisionSmileyBumper),
	.collisionSmileyBottom(collisionSmileyBottom)
);

logic reset_level_pulse;

game_controller game_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key5IsPressed(key5IsPressed),
	.collisionSmileyObstacle(collisionSmileyObstacle),
	.collisionSmileyObstacleGood(collisionSmileyObstacleGood),
	.collisionSmileyObstacleBad(collisionSmileyObstacleBad),
	.start(start),
	.collisionSmileyBottom(collisionSmileyBottom),
// output
	.pause(pause),
	.reset_level(reset_level),
	.reset_level_pulse(reset_level_pulse),
	.score(score),
	.level(level),
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

indications_block indications_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.life(life),
	.score(score),
	.level(level),
	.scoreNumber(scoreNumber),
// output
	.drawIndications(drawIndications),
	.RGBIndications(RGBIndications)
);

objects_mux_screen_main objects_mux_screen_main_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.draw_smiley(draw_smiley),
	.RGB_smiley(RGB_smiley),
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
	.RGB_backGround(RGB_backGround),
// output
	.RGB_screen_main(RGB_screen_main)
);

endmodule
