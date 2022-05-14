module game_controller(	
	input	logic 			clk,
	input	logic 			resetN,
	input	logic 			key5IsPressed,
	input	logic 			collisionSmileyBorderBottom,
	input	logic 			collisionSmileyObstacle,
	input	logic			collisionSmileyObstacleReal,
	output 	logic 			pause,
	output 	logic 			reset_level,
	output 	logic [3:0] 	score
);

enum logic [2:0] {state_1, state_2} state_present, state_next;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		state_present <= state_1;
		score <= 0;

	end
	else begin

		state_present <= state_next;

		if (collisionSmileyObstacleReal)
			score <= score + 1;

		if (collisionSmileyBorderBottom)
			score <= 0;

	end

end

always_comb
begin

	state_next = state_present;
	pause = 1;
	reset_level = 0;

	case (state_present)

		state_1: begin
			if (key5IsPressed)
				state_next = state_2;
		end

		state_2: begin

			pause = 0;

			if (collisionSmileyBorderBottom) begin
				reset_level = 1;
				state_next = state_1;
			end

		end

	endcase

end

endmodule
