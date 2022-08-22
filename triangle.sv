module triangle
#(parameter OBJECT_WIDTH, OBJECT_HEIGHT, TOP_LEFT_X, TOP_LEFT_Y, ORIENTATION)
(
	input 	logic [10:0]	pixelX,
	input 	logic [10:0]	pixelY,
	output	logic			draw,
	output 	logic [10:0]	offsetX,
	output 	logic [10:0]	offsetY
);

logic [10:0] rightX;
logic [10:0] bottomY;

logic [10:0] offsetXR;

assign bottomY	= TOP_LEFT_Y + OBJECT_HEIGHT;
assign rightX	= TOP_LEFT_X + OBJECT_WIDTH;

assign offsetX = pixelX - TOP_LEFT_X;
assign offsetY = pixelY - TOP_LEFT_Y;

assign offsetXR = rightX - pixelX;

assign draw = (
				(pixelX >= TOP_LEFT_X) && (pixelX < rightX) &&
				(pixelY >= TOP_LEFT_Y) && (pixelY < bottomY) &&
				(ORIENTATION == 0 ? (offsetX <= offsetY << 1) : (offsetXR <= offsetY << 1))
			);

endmodule
