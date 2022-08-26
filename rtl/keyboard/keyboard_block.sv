module keyboard_block(
	input 	logic 		clk,
	input 	logic 		resetN,
	input 	logic 		in,
	input 	logic 		kbd_dat,
	output 	logic 		key0IsPressed,
	output 	logic 		key1IsPressed,
	output 	logic 		key2IsPressed,
	output 	logic 		key4IsPressed,
	output 	logic 		key5IsPressed,
	output 	logic 		key6IsPressed,
	output 	logic 		key9IsPressed
);

logic 		make;
logic 		breakk;

logic [8:0]	key_code;

keyboard keyboard_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.in(in),
	.kbd_dat(kbd_dat),
// output
	.make(make),
	.breakk(breakk),
	.key_code(key_code)
);

key_decoder #(.KEY_VALUE(9'h070)) key_decoder_0_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.make(make),
	.breakk(breakk),
	.key_code(key_code),
// output
	.keyIsPressed(key0IsPressed)
);

key_decoder #(.KEY_VALUE(9'h069)) key_decoder_1_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.make(make),
	.breakk(breakk),
	.key_code(key_code),
// output
	.keyIsPressed(key1IsPressed)
);

key_decoder #(.KEY_VALUE(9'h072)) key_decoder_2_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.make(make),
	.breakk(breakk),
	.key_code(key_code),
// output
	.keyIsPressed(key2IsPressed)
);

key_decoder #(.KEY_VALUE(9'h06B)) key_decoder_4_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.make(make),
	.breakk(breakk),
	.key_code(key_code),
// output
	.keyIsPressed(key4IsPressed)
);

key_decoder #(.KEY_VALUE(9'h073)) key_decoder_5_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.make(make),
	.breakk(breakk),
	.key_code(key_code),
// output
	.keyIsPressed(key5IsPressed)
);

key_decoder #(.KEY_VALUE(9'h074)) key_decoder_6_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.make(make),
	.breakk(breakk),
	.key_code(key_code),
// output
	.keyIsPressed(key6IsPressed)
);

key_decoder #(.KEY_VALUE(9'h07D)) key_decoder_9_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.make(make),
	.breakk(breakk),
	.key_code(key_code),
// output
	.keyIsPressed(key9IsPressed)
);

endmodule
