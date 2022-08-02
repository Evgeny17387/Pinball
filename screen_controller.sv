module screen_controller(	
	input	logic 			clk,
	input	logic 			resetN,
	input	logic 			key0IsPressed,
	output 	logic 			start
);

enum logic [2:0] {state_0, state_1} state_present, state_next;

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

	case (state_present)

		state_0: begin

			if (key0IsPressed) begin
				state_next = state_1;
			end

		end

		state_1: begin

			start = 1;

		end

	endcase

end

endmodule
