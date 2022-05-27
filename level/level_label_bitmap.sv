import defines::LEVEL_LABEL_WIDTH, defines::LEVEL_LABEL_HEIGHT;

import defines::LEVEL_LABEL_COLOR;

module level_label_bitmap(
	input	logic			clk,
	input	logic			resetN,
	input 	logic	[10:0]	offsetX,
	input 	logic	[10:0] 	offsetY,
	input	logic			insideRectangle,
	output	logic			drawLabel,
	output	logic	[7:0]	RGBLabel
);

`ifdef PICTURES
bit [0:LEVEL_LABEL_HEIGHT - 1] [0:LEVEL_LABEL_WIDTH - 1] label_bitmap = {
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1000000000000000,
16'b	1111111111111111
};
`endif

always_ff@(posedge clk or negedge resetN)
begin

	if(!resetN) begin

		drawLabel <= 1'b0;

	end
	else begin

		drawLabel <= 1'b0;

		if (insideRectangle == 1'b1)

`ifdef PICTURES
			drawLabel <= label_bitmap[offsetY][offsetX];
`else
			drawLabel <= 1'b1;
`endif

	end

end

assign RGBLabel = LEVEL_LABEL_COLOR;

endmodule
