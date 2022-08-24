import defines::NUM_CREDITS;

module credit_control(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[3:0]	creditIndex,
	input	logic			collisionBallCredit,
	output	logic	[3:0]	number
);

logic [3:0] numbers[NUM_CREDITS] = '{0, 0, 0};

always_comb begin
	number = numbers[0];

	if (creditIndex == 1) begin
		number = numbers[1];
	end
	else if (creditIndex == 2) begin
		number = numbers[2];
	end
end

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		numbers = '{0, 0, 0};

	end
	else begin

		if (collisionBallCredit) begin

			if (creditIndex == 0) begin
				numbers[0] <= numbers[0] + 1;
			end
			else if (creditIndex == 1) begin
				numbers[1] <= numbers[1] + 1;
			end
			else if (creditIndex == 2) begin
				numbers[2] <= numbers[2] + 1;
			end

		end

	end

end

endmodule
