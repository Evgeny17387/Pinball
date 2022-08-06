module square
#(parameter OBJECT_WIDTH, OBJECT_HEIGHT, TOP_LEFT_X, TOP_LEFT_Y)
(
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	output	logic					draw,
	output 	logic			[10:0] 	offsetX,
	output 	logic			[10:0]  offsetY
);

int rightX;
int bottomY;

assign rightX 	= TOP_LEFT_X + OBJECT_WIDTH;
assign bottomY	= TOP_LEFT_Y + OBJECT_HEIGHT;

assign draw = ((pixelX >= TOP_LEFT_X) && (pixelX < rightX) && (pixelY >= TOP_LEFT_Y) && (pixelY < bottomY));

assign offsetX = pixelX - TOP_LEFT_X;
assign offsetY = pixelY - TOP_LEFT_Y;

endmodule
