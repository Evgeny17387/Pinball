module objects_mux_screen_main(
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
	input	logic		drawIndications,
	input	logic [7:0]	RGBIndications,
	input	logic [7:0] RGB_backGround,
	output	logic [7:0] RGB_screen_main
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN)
		RGB_screen_main <= 8'b0;
	else begin
		if (draw_smiley == 1'b1)
			RGB_screen_main <= RGB_smiley;
		else if (draw_flipper == 1'b1)
			RGB_screen_main <= RGB_flipper;
		else if (drawScore == 1'b1)
			RGB_screen_main <= RGBScore;
		else if (drawLevel == 1'b1)
			RGB_screen_main <= RGBLevel;
		else if (drawObstacle == 1'b1)
			RGB_screen_main <= RGBObstacle;
		else if (drawIndications == 1'b1)
			RGB_screen_main <= RGBIndications;
		else
			RGB_screen_main <= RGB_backGround;
	end

end

endmodule
