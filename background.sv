import defines::bracketOffset_h, defines::bracketOffset_top, defines::bracketOffset_bottom;
import defines::xFrameSize, defines::yFrameSize;
import defines::COLOR_DARK, defines::COLOR_LIGHT;

module background(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	pixelX,
	input	logic	[10:0]	pixelY,
	output	logic	[7:0]	RGB_backGround,
	output	logic			draw_top_boarder,
	output	logic			draw_bottom_boarder,
	output	logic			draw_left_boarder,
	output	logic			draw_right_boarder
);

logic [2:0] redBits;
logic [2:0] greenBits;
logic [1:0] blueBits;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		redBits <= COLOR_DARK;
		greenBits <= COLOR_DARK;
		blueBits <= COLOR_DARK;

		draw_top_boarder <= 1'b0;
		draw_bottom_boarder <= 1'b0;
		draw_left_boarder <= 1'b0;
		draw_right_boarder <= 1'b0;

	end 
	else begin

		greenBits <= 3'b110;
		redBits <= 3'b010;
		blueBits <= COLOR_LIGHT;

		draw_top_boarder <= 1'b0;
		draw_bottom_boarder <= 1'b0;
		draw_left_boarder <= 1'b0;
		draw_right_boarder <= 1'b0;

		if (pixelY == bracketOffset_top) begin
			redBits <= COLOR_DARK;
			greenBits <= COLOR_DARK;
			blueBits <= COLOR_DARK;

			draw_top_boarder <= 1'b1;
		end
		else if (pixelY == (yFrameSize - bracketOffset_bottom)) begin
			redBits <= COLOR_DARK;
			greenBits <= COLOR_DARK;
			blueBits <= COLOR_DARK;

			draw_bottom_boarder <= 1'b1;
		end
		else if (pixelX == bracketOffset_h) begin
			redBits <= COLOR_DARK;
			greenBits <= COLOR_DARK;
			blueBits <= COLOR_DARK;

			draw_left_boarder <= 1'b1;
		end
		else if (pixelX == (xFrameSize - bracketOffset_h)) begin
			redBits <= COLOR_DARK;
			greenBits <= COLOR_DARK;
			blueBits <= COLOR_DARK;

			draw_right_boarder <= 1'b1;
		end

	end

	RGB_backGround =  {redBits , greenBits , blueBits};

end

endmodule
