module square_object(
	input		logic	clk,
	input		logic	resetN,
	input 	logic signed	[10:0] 	PixelX,
	input 	logic signed	[10:0] 	PixelY,
	input 	logic signed	[10:0] 	topLeftX,
	input 	logic	signed 	[10:0] 	topLeftY,
	output 	logic				[10:0] 	offsetX,
	output 	logic				[10:0]  	offsetY,
	output	logic							draw,
	output	logic				[7:0]		RGB
);

parameter  int 			OBJECT_WIDTH_X 		= 60;
parameter  int 			OBJECT_HEIGHT_Y 		= 32;
parameter  logic [7:0] 	OBJECT_COLOR 			= 8'h5b; 
localparam logic [7:0] 	TRANSPARENT_ENCODING = 8'hFF;

int rightX;
int bottomY;

logic insideBracket;

assign rightX 	= topLeftX + OBJECT_WIDTH_X;
assign bottomY	= topLeftY + OBJECT_HEIGHT_Y;

assign insideBracket	= ((PixelX >= topLeftX) && (PixelX < rightX) && (PixelY >= topLeftY) && (PixelY < bottomY));

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGB <= 8'b0;
		draw	<=	1'b0;
	end

	else begin

		RGB <= TRANSPARENT_ENCODING;
		draw <= 1'b0;
		offsetX <= 0;
		offsetY <= 0;

		if (insideBracket) begin
			RGB <= OBJECT_COLOR;
			draw <= 1'b1;
			offsetX <= PixelX - topLeftX;
			offsetY <= PixelY - topLeftY;
		end 

	end

end 

endmodule
