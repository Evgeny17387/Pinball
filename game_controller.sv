import defines::LIFE_INIT;

module game_controller(	
	input	logic 			clk,
	input	logic 			resetN,
	input	logic 			key5IsPressed,
	input	logic 			collisionSmileyBorderBottom,
	input	logic 			collisionSmileyObstacle,
	input	logic			collisionSmileyObstacleReal,
	output 	logic 			pause,
	output 	logic 			reset_level,
	output 	logic [3:0] 	score,
	output 	logic [3:0] 	level,
	output 	logic [3:0] 	life
);

enum logic [2:0] {state_1, state_2, state_3} state_present, state_next;

logic [3:0] score_current, score_next;
logic [3:0] level_current, level_next;
logic [3:0] life_current, life_next;

assign score = score_current;
assign level = level_current;
assign life = life_current;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		state_present <= state_1;

		score_current <= 0;
		level_current <= 0;
		life_current <= LIFE_INIT;

	end
	else begin

		state_present <= state_next;

		score_current <= score_next;
		level_current <= level_next;
		life_current <= life_next;

	end

end

always_comb
begin

	state_next = state_present;

	score_next = score_current;
	level_next = level_current;
	life_next = life_current;

	pause = 1;

	reset_level = 0;

	case (state_present)

		state_1: begin

			score_next = 0;

			reset_level = 1;

			if (key5IsPressed) begin
				state_next = state_2;
			end

		end

		state_2: begin

			pause = 0;

			if (collisionSmileyBorderBottom) begin

				life_next = life_current - 1;

				if (life_next == 0) begin
					state_next = state_3;
				end
				else begin
					state_next = state_1;
				end

			end
			else if (collisionSmileyObstacleReal) begin

				if (score == 4'h1) begin
					state_next = state_1;
					level_next = level_current + 1;
				end
				else begin
					score_next = score_current + 1;
				end

			end

		end

		state_3: begin

			score_next = 0;
			level_next = 0;
			life_next = LIFE_INIT;

			reset_level = 1;

			if (key5IsPressed) begin
				state_next = state_2;
			end

		end

	endcase

end

endmodule
