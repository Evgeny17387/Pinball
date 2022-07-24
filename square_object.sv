import defines::COLOR_TRANSPARENT, defines::COLOR_DEFAULT;

module square_object
#(parameter OBJECT_WIDTH = 0, OBJECT_HEIGHT = 0)
(
	input	logic					clk,
	input	logic					resetN,
	input 	logic signed	[10:0] 	pixelX,
	input 	logic signed	[10:0] 	pixelY,
	input 	logic signed	[10:0] 	topLeftX,
	input 	logic signed 	[10:0] 	topLeftY,
	output 	logic			[10:0] 	offsetX,
	output 	logic			[10:0]  offsetY,
	output	logic					draw,
	output	logic			[7:0]	RGB
);

int rightX;
int bottomY;

logic insideBracket;

assign rightX 	= topLeftX + OBJECT_WIDTH;
assign bottomY	= topLeftY + OBJECT_HEIGHT;

assign insideBracket = ((pixelX >= topLeftX) && (pixelX < rightX) && (pixelY >= topLeftY) && (pixelY < bottomY));

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGB <= 8'b0;
		draw <= 1'b0;
	end

	else begin

		RGB <= COLOR_TRANSPARENT;
		draw <= 1'b0;
		offsetX <= 0;
		offsetY <= 0;

		if (insideBracket) begin
			RGB <= COLOR_DEFAULT;
			draw <= 1'b1;
			offsetX <= pixelX - topLeftX;
			offsetY <= pixelY - topLeftY;
		end 

	end

end 

endmodule
