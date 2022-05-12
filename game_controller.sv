module game_controller(	
	input	logic clk,
	input	logic resetN,
	input	logic draw_smiley,
	input	logic draw_top_boarder,
	input	logic draw_bottom_boarder,
	input	logic draw_left_boarder,
	input	logic draw_right_boarder,
	input	logic draw_flipper,
	input	logic key5IsPressed,
	output 	logic collisionSmileyBorderTop,
	output 	logic collisionSmileyBorderLeft,
	output 	logic collisionSmileyBorderRight,
	output 	logic collisionSmileyFlipper,
	output 	logic pause
);

assign collisionSmileyBorderTop 	= (draw_smiley && draw_top_boarder);
assign collisionSmileyBorderLeft 	= (draw_smiley && draw_left_boarder);
assign collisionSmileyBorderRight 	= (draw_smiley && draw_right_boarder);

assign collisionSmileyFlipper 	= (draw_smiley && draw_flipper);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		pause = 1;

	end 

	else begin

		if (key5IsPressed) begin
		
			pause <= 0;
		
		end
		else if (draw_smiley && draw_bottom_boarder) begin

			pause <= 1;

		end

	end

end

endmodule
