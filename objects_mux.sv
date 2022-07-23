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
	input	logic		drawLevel,
	input	logic [7:0]	RGBLevel,
	input	logic		drawStatusLevel,
	input	logic [7:0]	RGBStatusLevel,
	input	logic		drawIndications,
	input	logic [7:0]	RGBIndications,
	input	logic		drawWord,
	input	logic [7:0]	RGBWord,
	input	logic [7:0] RGB_backGround,
	output	logic [7:0] RGB
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN)
		RGB <= 8'b0;
	else begin
		if (draw_smiley == 1'b1)
			RGB <= RGB_smiley;
		else if (draw_flipper == 1'b1)
			RGB <= RGB_flipper;
		else if (drawScore == 1'b1)
			RGB <= RGBScore;
		else if (drawLevel == 1'b1)
			RGB <= RGBLevel;
		else if (drawStatusLevel == 1'b1)
			RGB <= RGBStatusLevel;
		else if (drawObstacle == 1'b1)
			RGB <= RGBObstacle;
		else if (drawIndications == 1'b1)
			RGB <= RGBIndications;
		else if (drawWord == 1'b1)
			RGB <= RGBWord;
		else
			RGB <= RGB_backGround;
	end

end

endmodule
