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
	output 	logic pause,
	output 	logic reset_level
);

assign collisionSmileyBorderTop 	= (draw_smiley && draw_top_boarder);
assign collisionSmileyBorderLeft 	= (draw_smiley && draw_left_boarder);
assign collisionSmileyBorderRight 	= (draw_smiley && draw_right_boarder);

assign collisionSmileyFlipper 	= (draw_smiley && draw_flipper);

enum logic [2:0] {state_1, state_2, state_3} state_present, state_next;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		state_present <= state_1;
	end
	else begin
		state_present <= state_next;
	end 

end

always_comb
begin

	state_next = state_present;
	pause = 1;
	reset_level = 0;

	case (state_present)

		state_1: begin
			if (key5IsPressed)
				state_next = state_2;
		end

		state_2: begin
			pause = 0;
			if (draw_smiley && draw_bottom_boarder) begin
				reset_level = 1;
				state_next = state_1;
			end
		end

	endcase

end

endmodule
