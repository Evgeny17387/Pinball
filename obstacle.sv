module Obstacle(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic					drawObstacle,
	output	logic			[7:0]	RGBObstacle
);

parameter  int 			OBJECT_WIDTH_X 			= 128;
parameter  int 			OBJECT_HEIGHT_Y			= 128;

parameter  logic [7:0] 	OBJECT_COLOR 			= 8'h55;

localparam logic [7:0] 	TRANSPARENT_ENCODING 	= 8'hFF;

int rightX;
int bottomY;

logic insideBracket;

logic signed	[10:0] 	topLeftX = 100;
logic signed 	[10:0] 	topLeftY = 100;

assign rightX 			= topLeftX + OBJECT_WIDTH_X;
assign bottomY 			= topLeftY + OBJECT_HEIGHT_Y;

assign insideBracket	= ((pixelX >= topLeftX) && (pixelX < rightX) && (pixelY >= topLeftY) && (pixelY < bottomY));

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

		RGBObstacle <= 8'b0;
		drawObstacle <= 1'b0;

	end

	else begin

		RGBObstacle <= TRANSPARENT_ENCODING;
		drawObstacle <= 1'b0;

		if (insideBracket) begin

			RGBObstacle <= OBJECT_COLOR;
			drawObstacle <= 1'b1;

		end 

	end

end 

endmodule
