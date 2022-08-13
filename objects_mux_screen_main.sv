module objects_mux_screen_main(
	input	logic		clk,
	input	logic		resetN,
	input	logic		draw_smiley,
	input	logic [7:0]	RGB_smiley,
	input	logic		draw_flipper,
	input	logic [7:0] RGB_flipper,
	input	logic		drawObstacle,
	input	logic [7:0]	RGBObstacle,
	input	logic		drawIndications,
	input	logic [7:0]	RGBIndications,
	input	logic		drawSpring,
	input	logic [7:0]	RGBSpring,
	input	logic		drawBumper,
	input	logic [7:0]	RGBBumper,
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
		else if (drawObstacle == 1'b1)
			RGB_screen_main <= RGBObstacle;
		else if (drawIndications == 1'b1)
			RGB_screen_main <= RGBIndications;
		else if (drawSpring == 1'b1)
			RGB_screen_main <= RGBSpring;
		else if (drawBumper == 1'b1)
			RGB_screen_main <= RGBBumper;
		else
			RGB_screen_main <= RGB_backGround;
	end

end

endmodule
