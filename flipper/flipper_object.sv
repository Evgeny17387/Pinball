module flipper_object(
	input		logic							clk,
	input		logic							resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input 	logic signed	[10:0] 	topLeftX,
	input 	logic	signed 	[10:0] 	topLeftY,
	output	logic							draw,
	output	logic				[7:0]		RGB
);

parameter  int 			OBJECT_WIDTH_X 		= 128;
parameter  int 			OBJECT_HEIGHT_Y 		= 32;

parameter  logic [7:0] 	OBJECT_COLOR 			= 8'h5b;

localparam logic [7:0] 	TRANSPARENT_ENCODING = 8'hFF;

int rightX;
int bottomY;

logic insideBracket;

assign rightX 	= topLeftX + OBJECT_WIDTH_X;
assign bottomY	= topLeftY + OBJECT_HEIGHT_Y;

assign insideBracket	= ((pixelX >= topLeftX) && (pixelX < rightX) && (pixelY >= topLeftY) && (pixelY < bottomY));

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGB <= 8'b0;
		draw <= 1'b0;
	end

	else begin

		RGB <= TRANSPARENT_ENCODING;
		draw <= 1'b0;

		if (insideBracket) begin
			RGB <= OBJECT_COLOR;
			draw <= 1'b1;
		end 

	end

end 

endmodule
