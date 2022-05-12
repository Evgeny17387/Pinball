module game_controller(	
	input	logic	clk,
	input	logic	resetN,
	input	logic	draw_smiley,
	input	logic	draw_boarders,
	input	logic	draw_bottom_boarder,
	input	logic	draw_flipper,
	output 	logic 	collisionSmileyBorders,
	output 	logic	collisionSmileyFlipper,
	output 	logic	pause
);

assign collisionSmileyBorders 	= (draw_smiley && draw_boarders);
assign collisionSmileyFlipper 	= (draw_smiley && draw_flipper);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		pause = 0;

	end 

	else begin
	
		if (draw_smiley && draw_bottom_boarder) begin

			pause <= 1;

		end

	end

end

endmodule
