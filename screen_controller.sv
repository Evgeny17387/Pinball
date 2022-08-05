module screen_controller(	
	input	logic 			clk,
	input	logic 			resetN,
	input	logic 			key0IsPressed,
	input	logic	[3:0]	life,
	output 	logic 			start,
	output 	logic 			game_end
);

enum logic [2:0] {state_0, state_1, state_2} state_present, state_next;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		state_present <= state_0;

	end
	else begin

		state_present <= state_next;

	end

end

always_comb
begin

	state_next = state_present;

	start = 0;

	game_end = 0;

	case (state_present)

		state_0: begin

			if (key0IsPressed) begin
				state_next = state_1;
			end

		end

		state_1: begin

			start = 1;

			if (life == 0) begin
				state_next = state_2;
			end

		end

		state_2: begin

			start = 1;

			game_end = 1;

		end


	endcase

end

endmodule
