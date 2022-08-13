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

logic	[7:0]	RGB_backGround;
logic	[7:0]	RGB_flipper;
logic	[7:0]	RGBObstacle;
logic	[7:0]	RGBIndications;

logic			draw_top_boarder;
logic			draw_bottom_boarder;
logic			draw_left_boarder;
logic			draw_right_boarder;
logic 			draw_flipper;
logic 			drawObstacle;
logic 			drawIndications;

logic			collisionSmileyBorderTop;
logic			collisionSmileyBorderBottom;
logic			collisionSmileyBorderLeft;
logic			collisionSmileyBorderRight;

logic			collisionSmileyFlipper;

logic 			collisionFlipperBorderLeft;
logic 			collisionFlipperBorderRight;

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
	.collisionSmileyBorderTop(collisionSmileyBorderTop),
	.collisionSmileyBorderLeft(collisionSmileyBorderLeft),
	.collisionSmileyBorderRight(collisionSmileyBorderRight),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.key5IsPressed(key5IsPressed),
	.pause(pause),
	.flipperSpeedX(flipperSpeedX),
	.reset_level(reset_level),
	.collisionSmileyObstacle(collisionSmileyObstacle),
	.level(level),
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
	.collisionFlipperBorderLeft(collisionFlipperBorderLeft),
	.collisionFlipperBorderRight(collisionFlipperBorderRight),
// output
	.RGB_flipper(RGB_flipper),
	.draw_flipper(draw_flipper),
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

background background_inst(
// input
	.clk(clk),
	.resetN(resetN),//
	.pixelX(pixelX),
	.pixelY(pixelY),
// output
	.RGB_backGround(RGB_backGround),
	.draw_top_boarder(draw_top_boarder),
	.draw_bottom_boarder(draw_bottom_boarder),
	.draw_left_boarder(draw_left_boarder),
	.draw_right_boarder(draw_right_boarder)
);

logic collisionSmileyObstacle;
logic collisionSmileyObstacleGood;
logic collisionSmileyObstacleBad;

CollisionDetector CollisionDetector_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.draw_smiley(draw_smiley),
	.draw_top_boarder(draw_top_boarder),
	.draw_bottom_boarder(draw_bottom_boarder),
	.draw_left_boarder(draw_left_boarder),
	.draw_right_boarder(draw_right_boarder),
	.draw_flipper(draw_flipper),
	.drawObstacle(drawObstacle),
	.drawScoreNumber(drawScoreNumber),
	.startOfFrame(startOfFrame),
// output
	.collisionSmileyBorderTop(collisionSmileyBorderTop),
	.collisionSmileyBorderBottom(collisionSmileyBorderBottom),
	.collisionSmileyBorderLeft(collisionSmileyBorderLeft),
	.collisionSmileyBorderRight(collisionSmileyBorderRight),
	.collisionSmileyFlipper(collisionSmileyFlipper),
	.collisionFlipperBorderLeft(collisionFlipperBorderLeft),
	.collisionFlipperBorderRight(collisionFlipperBorderRight),
	.collisionSmileyObstacle(collisionSmileyObstacle),
	.collisionSmileyObstacleGood(collisionSmileyObstacleGood),
	.collisionSmileyObstacleBad(collisionSmileyObstacleBad)
);

logic reset_level_pulse;

game_controller game_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.key5IsPressed(key5IsPressed),
	.collisionSmileyBorderBottom(collisionSmileyBorderBottom),
	.collisionSmileyObstacle(collisionSmileyObstacle),
	.collisionSmileyObstacleGood(collisionSmileyObstacleGood),
	.collisionSmileyObstacleBad(collisionSmileyObstacleBad),
	.start(start),
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

spring_block spring_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(pixelX),
	.pixelY(pixelY),
	.key5IsPressed(key5IsPressed),
	.startOfFrame(startOfFrame),
// output
	.drawSpring(drawSpring),
	.RGBSpring(RGBSpring)
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
	.draw_flipper(draw_flipper),
	.RGB_flipper(RGB_flipper),
	.drawObstacle(drawObstacle),
	.RGBObstacle(RGBObstacle),
	.drawIndications(drawIndications),
	.RGBIndications(RGBIndications),
	.drawSpring(drawSpring),
	.RGBSpring(RGBSpring),
	.RGB_backGround(RGB_backGround),
// output
	.RGB_screen_main(RGB_screen_main)
);

endmodule
