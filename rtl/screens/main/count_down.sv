module count_down(
    input   logic			clk,
    input	logic			resetN,
	input	logic			reset_level_pulse,
	input	logic			collisionBallTrap,
	output	logic	[3:0]	countDownNumber
);

logic countDownEnabe;

logic skipOneClockCycle;

always_ff@(posedge clk or negedge resetN) begin

	if (!resetN) begin

		countDownEnabe <= 1'b0;

	end else begin

		if (reset_level_pulse) begin

			countDownNumber <= counter;

		end else if (collisionBallTrap) begin

			countDownEnabe <= 1'b1;

		end else if (countDownEnabe) begin

			if (oneSecPulse) begin

				if (countDownNumber == 4'h0) begin

					countDownEnabe <= 1'b0;

				end else begin

					countDownNumber <= countDownNumber - 1;

				end

			end

		end

	end

end

logic oneSecPulse;

one_sec_counter one_sec_counter_inst(
// input
	.clk(clk),
	.resetN(resetN),
// output
	.oneSecPulse(oneSecPulse)
);

logic [3:0] counter;

counter counter_inst(
// input
	.clk(clk),
	.resetN(resetN),
// output
	.counter(counter)
);

endmodule
