module back_ground_draw(
	input		logic				clk,
	input		logic				resetN,
	input		logic	[10:0]	PixelX,
	input		logic	[10:0]	PixelY,
	output	logic	[7:0]		RGB_backGround,
	output	logic				draw_boarders
);

const int xFrameSize = 635;
const int yFrameSize = 475;

const int bracketOffset = 30;

logic [2:0] redBits;
logic [2:0] greenBits;
logic [1:0] blueBits;

logic [10:0] shift_pixelX;

localparam logic [2:0] DARK_COLOR = 3'b111; // bitmap of a dark color
localparam logic [2:0] LIGHT_COLOR = 3'b000; // bitmap of a light color

localparam int RED_TOP_Y = 156;
localparam int RED_LEFT_X = 256;
localparam int GREEN_RIGHT_X = 32;
localparam int BLUE_BOTTOM_Y = 300;
localparam int BLUE_RIGHT_X = 200;

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

		// 1. draw the yellow borders
		if (PixelX == 0 || PixelY == 0  || PixelX == xFrameSize || PixelY == yFrameSize)
		begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= LIGHT_COLOR; // 3rd bit will be truncated
		end

		// 2. draw  four lines with "bracketOffset" offset from the border
		if (PixelX == bracketOffset || PixelY == bracketOffset || PixelX == (xFrameSize - bracketOffset) || PixelY == (yFrameSize - bracketOffset))
		begin
			redBits <= DARK_COLOR;
			greenBits <= DARK_COLOR;
			blueBits <= DARK_COLOR;
			draw_boarders <= 1'b1; // pulse if drawing the boarders
		end

		// 3. draw red rectangle at the bottom right,  green on the left, and blue on top left
		if (PixelY > RED_TOP_Y && PixelX >= RED_LEFT_X) // rectangles on part of the screen 
			redBits <= DARK_COLOR;
		if (GREEN_RIGHT_X < GREEN_RIGHT_X)
			greenBits <= 3'b011;
		if (PixelX < BLUE_RIGHT_X && PixelY < BLUE_BOTTOM_Y)
			blueBits <= 2'b10;

		// 4. draw a matrix of 16*16 rectangles with all the colors, each rectsangle 8*8 pixels
		if ((PixelY > 8) && (PixelY < 24) && (PixelX > 30) && (PixelX < 542))
		begin
			shift_pixelX <= PixelX - 29;
			blueBits <= shift_pixelX[2:1];
			greenBits <= shift_pixelX[5:3];
			redBits <= shift_pixelX[8:6];
		end 

	end

	RGB_backGround =  {redBits , greenBits , blueBits}; //collect color nibbles to an 8 bit word

end

endmodule
