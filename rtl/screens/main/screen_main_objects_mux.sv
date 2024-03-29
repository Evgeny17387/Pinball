module screen_main_objects_mux(
	input	logic		clk,
	input	logic		resetN,
	input	logic		drawBall,
	input	logic [7:0]	RGBBall,
	input	logic		drawFlipper,
	input	logic [7:0] RGB_flipper,
	input	logic		drawObstacle,
	input	logic [7:0]	RGBObstacle,
	input	logic		drawIndications,
	input	logic [7:0]	RGBIndications,
	input	logic		drawSpring,
	input	logic [7:0]	RGBSpring,
	input	logic		drawBumper,
	input	logic [7:0]	RGBBumper,
	input	logic		drawCredit,
	input	logic [7:0]	RGBCredit,
	input	logic		drawTrap,
	input	logic [7:0]	RGBTrap,
	input	logic [7:0] RGB_backGround,
	output	logic [7:0] RGB_screen_main
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN)
		RGB_screen_main <= 8'b0;
	else begin
		if (drawBall == 1'b1)
			RGB_screen_main <= RGBBall;
		else if (drawFlipper == 1'b1)
			RGB_screen_main <= RGB_flipper;
		else if (drawObstacle == 1'b1)
			RGB_screen_main <= RGBObstacle;
		else if (drawIndications == 1'b1)
			RGB_screen_main <= RGBIndications;
		else if (drawSpring == 1'b1)
			RGB_screen_main <= RGBSpring;
		else if (drawBumper == 1'b1)
			RGB_screen_main <= RGBBumper;
		else if (drawCredit == 1'b1)
			RGB_screen_main <= RGBCredit;
		else if (drawTrap == 1'b1)
			RGB_screen_main <= RGBTrap;
		else
			RGB_screen_main <= RGB_backGround;
	end

end

endmodule
