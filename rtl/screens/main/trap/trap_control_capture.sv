module trap_control_capture(
	input	logic			clk,
	input	logic			resetN,
	input 	logic 			reset_level_pulse,
	input	logic			collisionBallTrap,
	input	logic			startOfFrame,
	output	logic	[3:0]	countDownNumber,
	output	logic			controlledByTrap
);

enum logic [2:0] {state_0, state_1, state_2} state_present, state_next;

logic resetCounterAfterCollistion;

logic enableCountDown;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		state_present <= state_0;

		controlledByTrapStopCounterCurrent <= 0;

	end
	else begin

		state_present <= state_next;

		controlledByTrapStopCounterCurrent <= controlledByTrapStopCounterNext;

	end

end

byte controlledByTrapStopCounterCurrent, controlledByTrapStopCounterNext;

always_comb
begin

	state_next = state_present;

	controlledByTrap = 0;

	enableCountDown = 0;

	resetCounterAfterCollistion = 0;

	controlledByTrapStopCounterNext = controlledByTrapStopCounterCurrent;

	case (state_present)

		state_0: begin

			if (collisionBallTrap) begin

				state_next = state_1;

			end

		end

		state_1: begin

			if (countDownNumber > 0) begin

				controlledByTrap = 1;

				enableCountDown = 1;

			end else begin

				controlledByTrapStopCounterNext = 80;

				state_next = state_2;

			end

		end

		state_2: begin

			if (controlledByTrapStopCounterCurrent > 0) begin

				if (startOfFrame) begin
					
					controlledByTrapStopCounterNext = controlledByTrapStopCounterCurrent - 1;

				end

			end else begin

				resetCounterAfterCollistion = 1;

				state_next = state_0;

			end

		end

	endcase

end

count_down count_down_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.enable(enableCountDown),
	.resetCounter(reset_level_pulse || resetCounterAfterCollistion),
// output
	.countDownNumber(countDownNumber)
);

endmodule
