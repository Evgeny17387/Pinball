import defines::bracketOffset_h, defines::bracketOffset_top, defines::bracketOffset_bottom;

module background(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	PixelX,
	input	logic	[10:0]	PixelY,
	output	logic	[7:0]	RGB_backGround,
	output	logic			draw_top_boarder,
	output	logic			draw_bottom_boarder,
	output	logic			draw_left_boarder,
	output	logic			draw_right_boarder
);

const int xFrameSize = 635;
const int yFrameSize = 475;

logic [2:0] redBits;
logic [2:0] greenBits;
logic [1:0] blueBits;

localparam logic [2:0] DARK_COLOR = 3'b111;
localparam logic [2:0] LIGHT_COLOR = 3'b000;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		redBits <= DARK_COLOR;
		greenBits <= DARK_COLOR;
		blueBits <= DARK_COLOR;

		draw_top_boarder <= 1'b0;
		draw_bottom_boarder <= 1'b0;
		draw_left_boarder <= 1'b0;
		draw_right_boarder <= 1'b0;

	end 
	else begin

		greenBits <= 3'b110;
		redBits <= 3'b010;
		blueBits <= LIGHT_COLOR;

		draw_top_boarder <= 1'b0;
		draw_bottom_boarder <= 1'b0;
		draw_left_boarder <= 1'b0;
		draw_right_boarder <= 1'b0;

		if (PixelY == bracketOffset_top) begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= DARK_COLOR;

			draw_top_boarder <= 1'b1;
		end
		else if (PixelY == (yFrameSize - bracketOffset_bottom)) begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= DARK_COLOR;

			draw_bottom_boarder <= 1'b1;
		end
		else if (PixelX == bracketOffset_h) begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= DARK_COLOR;

			draw_left_boarder <= 1'b1;
		end
		else if (PixelX == (xFrameSize - bracketOffset_h)) begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= DARK_COLOR;

			draw_right_boarder <= 1'b1;
		end

	end

	RGB_backGround =  {redBits , greenBits , blueBits};

end

endmodule
