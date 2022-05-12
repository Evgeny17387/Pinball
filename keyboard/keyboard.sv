module keyboard(
	input 	logic 		clk,
	input 	logic 		resetN,
	input 	logic 		in,
	input 	logic 		kbd_dat,
   output	logic 		make,
   output  	logic 		breakk,
   output  	logic [8:0]	key_code
);

logic 		kbd_clk;
logic 		din_new;
logic [7:0] din;

lpf lpf_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.in(in),
// output
	.out_filt(kbd_clk)
);

bitrec bitrec_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.kbd_clk(kbd_clk),
	.kbd_dat(kbd_dat),
// output
	.dout_new(din_new),
	.dout(din)
);

byterec byterec_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.din_new(din_new),
	.din(din),
// output
	.make(make),
	.breakk(breakk),
	.key_code(key_code)
);

endmodule
