import defines::SCREEN_MAIN_TRAP_RADIUS_OUTER, defines::SCREEN_MAIN_TRAP_RADIUS_INNER;
import defines::TRAP_COLOR;

module trap_block(
	input	logic			clk,
	input	logic			resetN,
	input 	logic	[10:0] 	pixelX,
	input 	logic	[10:0]	pixelY,
	input	logic 			startOfFrame,
	input 	logic 			reset_level,
	input 	logic 			reset_level_pulse,
	input 	logic 			pause,
	input	logic			collisionBallTrap,
	output	logic	[7:0]	RGBTrap,
	output 	logic 			drawTrap,
	output	logic	[10:0]	centerX,
	output	logic	[10:0]	centerY,
	output	logic			controlledByTrap,
	output	logic	[3:0]	countDownNumber
);

trap_control_capture trap_control_capture_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.reset_level_pulse(reset_level_pulse),
	.collisionBallTrap(collisionBallTrap),
	.startOfFrame(startOfFrame),
// output
	.countDownNumber(countDownNumber),
	.controlledByTrap(controlledByTrap)
);

trap_control_movement trap_control_movement_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.startOfFrame(startOfFrame),
	.reset_level(reset_level),
	.pause(pause),
// output
	.centerX(centerX),
	.centerY(centerY)
);

cylinder_dynamic #(.RADIUS_OUTER(SCREEN_MAIN_TRAP_RADIUS_OUTER), .RADIUS_INNER(SCREEN_MAIN_TRAP_RADIUS_INNER)) cylinder_dynamic_inst(
// input
	.pixelX(pixelX),
	.pixelY(pixelY),
	.centerX(centerX),
	.centerY(centerY),
// output
	.draw(drawTrap)
);

object #(.COLOR(TRAP_COLOR)) object_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.insideObject(drawTrap),
// output
	.RGBObject(RGBTrap)
);

endmodule
