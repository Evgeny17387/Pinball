module objects_mux(
	input		logic	clk,
	input		logic	resetN,
	input		logic	draw_smiley,
	input		logic	[7:0] RGB_smiley,
	input		logic	[7:0] RGB_backGround,
	output	logic	[7:0] RGB
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGB <= 8'b0;
	end
	else begin
		if (draw_smiley == 1'b1)
			RGB <= RGB_smiley;
		else 
			RGB <= RGB_backGround;
		end
	end

endmodule
