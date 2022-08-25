module square_dynamic
#(parameter OBJECT_WIDTH, OBJECT_HEIGHT)
(
	input 	logic	[10:0] 	pixelX,
	input 	logic	[10:0] 	pixelY,
	input 	logic 	[10:0] 	topLeftX,
	input 	logic 	[10:0] 	topLeftY,
	output	logic			draw,
	output 	logic	[10:0] 	offsetX,
	output 	logic	[10:0]  offsetY
);

int rightX;
int bottomY;

assign rightX 	= topLeftX + OBJECT_WIDTH;
assign bottomY	= topLeftY + OBJECT_HEIGHT;

assign draw = ((pixelX >= topLeftX) && (pixelX < rightX) && (pixelY >= topLeftY) && (pixelY < bottomY));

assign offsetX = pixelX - topLeftX;
assign offsetY = pixelY - topLeftY;

endmodule
