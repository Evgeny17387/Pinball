import defines::SCREEN_MAIN_TRAP_CENTER_X, defines::SCREEN_MAIN_TRAP_CENTER_Y;

module trap_control(
	input	logic			clk,
	input	logic			resetN,
	input	logic 			startOfFrame,
	input 	logic 			reset_level,
	input 	logic 			pause,
	output	logic	[10:0]	centerX,
	output	logic	[10:0]	centerY
);

assign centerX = centerXCurrent;
assign centerY = centerYCurrent;

logic [10:0] centerXCurrent, centerXNext;
logic [10:0] centerYCurrent, centerYNext;

enum logic [2:0] {path_0, path_1, path_2, path_3} path_current, path_next;

// trap trajectory
// 0 - - - 1
// |       |
// |       |
// 3 - - - 2
// path 0: 0 -> 1
// path 1: 1 -> 2
// path 2: 2 -> 3
// path 3: 3 -> 0

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		centerXCurrent <= SCREEN_MAIN_TRAP_CENTER_X[0];
		centerYCurrent <= SCREEN_MAIN_TRAP_CENTER_Y[0];

		path_current <= path_0;

	end
	else begin

		centerXCurrent <= centerXNext;
		centerYCurrent <= centerYNext;

		path_current <= path_next;

	end

end

always_comb begin

	centerXNext = centerXCurrent;
	centerYNext = centerYCurrent;

	path_next = path_current;

	if (reset_level) begin

		centerXNext <= SCREEN_MAIN_TRAP_CENTER_X[0];
		centerYNext <= SCREEN_MAIN_TRAP_CENTER_Y[0];

		path_next <= path_0;

	end else if (startOfFrame && !pause) begin

		case (path_current)

			path_0: begin
				if (centerXCurrent == SCREEN_MAIN_TRAP_CENTER_X[1]) begin
					path_next = path_1;
				end else begin
					centerXNext = centerXCurrent + 1;
				end
			end

			path_1: begin
				if (centerYCurrent == SCREEN_MAIN_TRAP_CENTER_Y[2]) begin
					path_next = path_2;
				end else begin
					centerYNext = centerYCurrent + 1;
				end
			end

			path_2: begin
				if (centerXCurrent == SCREEN_MAIN_TRAP_CENTER_X[3]) begin
					path_next = path_3;
				end else begin
					centerXNext = centerXCurrent - 1;
				end
			end

			path_3: begin
				if (centerYCurrent == SCREEN_MAIN_TRAP_CENTER_Y[0]) begin
					path_next = path_0;
				end else begin
					centerYNext = centerYCurrent - 1;
				end
			end

		endcase

	end

end

endmodule
