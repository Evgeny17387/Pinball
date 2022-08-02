module objects_mux(
	input	logic		clk,
	input	logic		resetN,
	input	logic		start,
	input	logic [7:0] RGB_screen_welcome,
	input	logic [7:0] RGB_screen_main,
	output	logic [7:0] RGB
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN)
		RGB <= 8'b0;
	else begin
		if (!start)
			RGB <= RGB_screen_welcome;
		else
			RGB <= RGB_screen_main;
	end

end

endmodule
