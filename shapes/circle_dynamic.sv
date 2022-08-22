module circle_dynamic
#(parameter RADIUS)
(
	input 	logic [10:0] 	pixelX,
	input 	logic [10:0] 	pixelY,
	input 	logic [10:0] 	topLeftX,
	input 	logic [10:0]	topLeftY,
	output	logic 			draw,
	output 	logic [10:0]	offsetX,
	output 	logic [10:0]	offsetY
);

int centerX;
int centerY;

assign centerX = topLeftX + RADIUS;
assign centerY = topLeftY + RADIUS;

int offsetCenterX;
int offsetCenterY;

assign offsetCenterX = pixelX - centerX;
assign offsetCenterY = pixelY - centerY;

assign draw = ((offsetCenterX * offsetCenterX) + (offsetCenterY * offsetCenterY)) <= (RADIUS * RADIUS);

assign offsetX = pixelX - topLeftX;
assign offsetY = pixelY - topLeftY;

endmodule
