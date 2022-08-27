module count_down(
    input   logic			clk,
    input	logic			resetN,
	input	logic			enable,
	input	logic			resetCounter,
	output	logic	[3:0]	countDownNumber
);

always_ff@(posedge clk or negedge resetN) begin

	if (!resetN) begin

		countDownNumber <= counter;

	end else begin

		if (resetCounter) begin

			countDownNumber <= counter;

		end else if (enable && oneSecPulse && (countDownNumber > 4'h0)) begin

			countDownNumber <= countDownNumber - 1;

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
