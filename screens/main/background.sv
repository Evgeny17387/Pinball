import defines::FRAME_OFFSET_HORIZONTAL, defines::FRAME_OFFSET_TOP, defines::FRAME_OFFSET_BOTTOM;
import defines::FRAME_SPRING_OFFSET_LEFT, defines::FRAME_SPRING_OFFSET_TOP;
import defines::FRAME_SIZE_X, defines::FRAME_SIZE_Y;
import defines::COLOR_WHITE, defines::COLOR_BLACK;

module background(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	output	logic	[7:0]	RGB_backGround,
	output	logic			drawFrame,
	output	logic			drawBottom
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		drawFrame <= 1'b0;
		RGB_backGround =  COLOR_BLACK;
		drawBottom <= 1'b0;

	end 
	else begin

		drawFrame <= 1'b0;
		RGB_backGround =  COLOR_BLACK;
		drawBottom <= 1'b0;

		if (
			(pixelY == FRAME_OFFSET_TOP) ||
			(pixelX == FRAME_OFFSET_HORIZONTAL) ||
			(pixelX == (FRAME_SIZE_X - FRAME_OFFSET_HORIZONTAL)) ||
			((pixelX == FRAME_SPRING_OFFSET_LEFT) && (pixelY > FRAME_SPRING_OFFSET_TOP))
		) begin

			RGB_backGround <= COLOR_WHITE;
			drawFrame 	<= 1'b1;

		end
		else if (pixelY == (FRAME_SIZE_Y - FRAME_OFFSET_BOTTOM)) begin

			RGB_backGround <= COLOR_BLACK;
			drawBottom <= 1'b1;

		end

	end


end

endmodule
