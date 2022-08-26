import defines::SCREEN_MAIN_TRAP_RADIUS_OUTER, defines::SCREEN_MAIN_TRAP_RADIUS_INNER;
import defines::TRAP_COLOR;
import defines::SCREEN_MAIN_TRAP_INITIAL_CENTER_X, defines::SCREEN_MAIN_TRAP_INITIAL_CENTER_Y;

module trap_block(
	input	logic			clk,
	input	logic			resetN,
	input 	logic	[10:0] 	pixelX,
	input 	logic	[10:0]	pixelY,
	output	logic	[7:0]	RGBTrap,
	output 	logic 			drawTrap
);

logic [10:0] centerX;
logic [10:0] centerY;

assign centerX = SCREEN_MAIN_TRAP_INITIAL_CENTER_X;
assign centerY = SCREEN_MAIN_TRAP_INITIAL_CENTER_Y;

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
