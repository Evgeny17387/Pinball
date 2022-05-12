module background(
	input	logic			clk,
	input	logic			resetN,
	input	logic	[10:0]	PixelX,
	input	logic	[10:0]	PixelY,
	output	logic	[7:0]	RGB_backGround,
	output	logic			draw_boarders,
	output	logic			draw_bottom_boarder
);

const int xFrameSize = 635;
const int yFrameSize = 475;

const int bracketOffset = 30;

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

	end 
	else begin

		greenBits <= 3'b110;
		redBits <= 3'b010;
		blueBits <= LIGHT_COLOR;
		draw_boarders <= 1'b0;
		draw_bottom_boarder <= 1'b0;

		if ((PixelX == bracketOffset) || (PixelY == bracketOffset) || (PixelX == (xFrameSize - bracketOffset)))
		begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= DARK_COLOR;
			draw_boarders <= 1'b1;
		end

		if (PixelY == (yFrameSize - bracketOffset))
		begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= DARK_COLOR;
			draw_bottom_boarder <= 1'b1;
		end

	end

	RGB_backGround =  {redBits , greenBits , blueBits};

end

endmodule
