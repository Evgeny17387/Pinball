module game_controller(
	input	logic	clk,
	input	logic	resetN,
	input	logic	draw_smiley,
	input	logic	draw_boarders,
	input	logic	draw_flipper,
	output logic collisionSmileyBorders,
	output logic collisionSmileyFlipper
);

assign collisionSmileyBorders = (draw_smiley && draw_boarders);
assign collisionSmileyFlipper = (draw_smiley && draw_flipper);

endmodule
