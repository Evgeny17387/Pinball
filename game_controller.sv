module game_controller(
	input	logic	clk,
	input	logic	resetN,
	input	logic	drawing_request_Ball,
	input	logic	drawing_request_1,
	output logic collision
);

assign collision = (drawing_request_Ball && drawing_request_1);

endmodule
