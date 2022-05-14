module objects_mux(
	input	logic		clk,
	input	logic		resetN,
	input	logic		draw_smiley,
	input	logic [7:0]	RGB_smiley,
	input	logic		draw_flipper,
	input	logic [7:0] RGB_flipper,
	input	logic		drawObstacle,
	input	logic [7:0]	RGBObstacle,
	input	logic		drawScore,
	input	logic [7:0]	RGBScore,
	input	logic [7:0] RGB_backGround,
	output	logic [7:0] RGB
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGB <= 8'b0;
	end
	else begin
		if (draw_smiley == 1'b1) begin
			RGB <= RGB_smiley;
		end
		else if (draw_flipper == 1'b1) begin
			RGB <= RGB_flipper;
		end
		else if (drawScore == 1'b1) begin
			RGB <= RGBScore;
		end
		else if (drawObstacle == 1'b1) begin
			RGB <= RGBObstacle;
		end
		else begin
			RGB <= RGB_backGround;
		end
	end

end

endmodule
