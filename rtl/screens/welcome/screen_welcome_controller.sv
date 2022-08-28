import defines::COLOR_DEFAULT, defines::COLOR_RED;

module screen_welcome_controller(
	input	logic 			clk,
	input	logic 			resetN,
	input	logic 			key2IsPressed,
	input	logic 			key4IsPressed,
	input	logic 			key6IsPressed,
	input	logic 			key8IsPressed,
	input	logic			screenWelcomeOperational,
	input	logic			oneSecPulse,
	output	logic	[7:0]	colorSingle,
	output	logic	[7:0]	colorDual,
	output	logic			flipperType,
	output	logic	[3:0]	playerId
);

logic [7:0] colorSingleCurrent, colorSingleNext;
logic [7:0] colorDualCurrent, colorDualNext;
logic flipperTypeCurrent, flipperTypeNext;
logic [3:0] playerIdCurrent, playerIdNext;
int counterKeyboardCurrent, counterKeyboardNext;

assign colorSingle = colorSingleCurrent;
assign colorDual = colorDualCurrent;
assign flipperType = flipperTypeCurrent;
assign playerId = playerIdCurrent;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		colorSingleCurrent <= COLOR_DEFAULT;
		colorDualCurrent <= COLOR_DEFAULT;
		flipperTypeCurrent <= 1'b0;
		counterKeyboardCurrent <= 0;

	end
	else begin

		colorSingleCurrent <= colorSingleNext;
		colorDualCurrent <= colorDualNext;
		flipperTypeCurrent <= flipperTypeNext;
		playerIdCurrent <= playerIdNext;
		counterKeyboardCurrent <= counterKeyboardNext;

	end

end

always_comb
begin

	playerIdNext = playerIdCurrent;
	counterKeyboardNext = counterKeyboardCurrent;

	if (screenWelcomeOperational) begin

		if (counterKeyboardCurrent > 0) begin

			if (oneSecPulse) begin

				counterKeyboardNext = counterKeyboardCurrent - 1;

			end

		end else if (key8IsPressed) begin
			playerIdNext = playerIdCurrent + 1;
			counterKeyboardNext = 1;
		end else if (key2IsPressed) begin
			playerIdNext = playerIdCurrent - 1;
			counterKeyboardNext = 1;
		end

	end

end

always_comb
begin

	flipperTypeNext = flipperTypeCurrent;

	if (screenWelcomeOperational) begin

		if (key4IsPressed) begin
			flipperTypeNext = 0;
		end else if (key6IsPressed) begin
			flipperTypeNext = 1;
		end

	end

end

always_comb
begin

	colorSingleNext = colorSingleCurrent;
	colorDualNext = colorDualCurrent;

	if (flipperTypeCurrent == 1'b0) begin
			colorSingleNext = COLOR_RED;
			colorDualNext = COLOR_DEFAULT;
	end else begin
			colorSingleNext = COLOR_DEFAULT;
			colorDualNext = COLOR_RED;
	end

end

endmodule
