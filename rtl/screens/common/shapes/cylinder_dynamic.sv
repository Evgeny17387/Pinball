module cylinder_dynamic
#(parameter RADIUS_OUTER, RADIUS_INNER)
(
	input 	logic [10:0] 	pixelX,
	input 	logic [10:0] 	pixelY,
	input 	logic [10:0] 	centerX,
	input 	logic [10:0]	centerY,
	output	logic 			draw
);

int offsetCenterX;
int offsetCenterY;
assign offsetCenterX = pixelX - centerX;
assign offsetCenterY = pixelY - centerY;

int offsetCenterSqr;
assign offsetCenterSqr = offsetCenterX * offsetCenterX + offsetCenterY * offsetCenterY;

assign draw = ((offsetCenterSqr <= RADIUS_OUTER * RADIUS_OUTER) && (offsetCenterSqr > RADIUS_INNER * RADIUS_INNER));

endmodule
