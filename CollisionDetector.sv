module CollisionDetector(
	input	logic 			clk,
	input	logic 			resetN,
	input	logic 			draw_smiley,
	input	logic 			draw_top_boarder,
	input	logic 			draw_bottom_boarder,
	input	logic 			draw_left_boarder,
	input	logic 			draw_right_boarder,
	input	logic 			draw_flipper,
	input	logic 			drawObstacle,
	input	logic			drawGoodNumber,
	input 	logic 			startOfFrame,
	output	logic 			collisionSmileyBorderTop,
	output	logic 			collisionSmileyBorderBottom,
	output 	logic 			collisionSmileyBorderLeft,
	output 	logic 			collisionSmileyBorderRight,
	output 	logic 			collisionSmileyFlipper,
	output 	logic 			collisionFlipperBorderLeft,
	output 	logic 			collisionFlipperBorderRight,
	output	logic 			collisionSmileyObstacle,
	output	logic 			collisionSmileyObstacleGood,
	output	logic 			collisionSmileyObstacleBad
);

assign collisionSmileyBorderTop 	= draw_smiley && draw_top_boarder;
assign collisionSmileyBorderBottom	= draw_smiley && draw_bottom_boarder;
assign collisionSmileyBorderLeft 	= draw_smiley && draw_left_boarder;
assign collisionSmileyBorderRight 	= draw_smiley && draw_right_boarder;

assign collisionSmileyFlipper 		= draw_smiley && draw_flipper;

assign collisionSmileyObstacle		= draw_smiley && drawObstacle;
assign collisionSmileyObstacleGood	= collisionSmileyObstacle && drawGoodNumber;
assign collisionSmileyObstacleBad	= collisionSmileyObstacle && !drawGoodNumber;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin

	end
	else begin

		if (startOfFrame) begin
			collisionFlipperBorderLeft <= 0;
			collisionFlipperBorderRight <= 0;
		end
		else begin
			if (draw_flipper && draw_left_boarder)
				collisionFlipperBorderLeft <= 1;
			if (draw_flipper && draw_right_boarder)
				collisionFlipperBorderRight <= 1;
		end
	end

end

endmodule
