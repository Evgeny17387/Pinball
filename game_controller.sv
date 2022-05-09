module game_controller(
	input	logic	clk,
	input	logic	resetN,
	input	logic	draw_smiley,
	input	logic	draw_boarders,
	output logic collision
);

assign collision = (draw_smiley && draw_boarders);

endmodule
