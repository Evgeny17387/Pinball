module smiley_bitmap(	
	input	logic			clk,
	input	logic			resetN,
	input 	logic	[10:0] 	offsetX,
	input 	logic	[10:0] 	offsetY,
	input	logic			InsideRectangle,
	output	logic			draw_smiley,
	output	logic	[7:0] 	RGB_smiley,
	output 	logic	[3:0]	hitEdgeCode
);

localparam  int OBJECT_NUMBER_OF_Y_BITS = 6;
localparam  int OBJECT_NUMBER_OF_X_BITS = 6;

localparam  int OBJECT_HEIGHT_Y = 1 <<  OBJECT_NUMBER_OF_Y_BITS;
localparam  int OBJECT_WIDTH_X = 1 <<  OBJECT_NUMBER_OF_X_BITS;

localparam  int OBJECT_HEIGHT_Y_DIVIDER = OBJECT_NUMBER_OF_Y_BITS - 2;
localparam  int OBJECT_WIDTH_X_DIVIDER =  OBJECT_NUMBER_OF_X_BITS - 2;

localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF;

`ifdef PICTURES
logic [0:OBJECT_HEIGHT_Y-1] [0:OBJECT_WIDTH_X-1] [7:0] object_colors = {
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h01,8'h00,8'h4a,8'h52,8'h92,8'h92,8'h92,8'h92,8'h92,8'h4a,8'h4a,8'h00,8'h01,8'h00,8'h01,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h00,8'h00,8'h01,8'h4a,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h4a,8'h00,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h00,8'h00,8'h01,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h01,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h01,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h4a,8'h01,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h49,8'h4a,8'h49,8'h49,8'h4a,8'h49,8'h4a,8'h4a,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h4a,8'h4a,8'h49,8'h49,8'h49,8'h49,8'h4a,8'h4a,8'h49,8'h4a,8'h4a,8'h4a,8'h49,8'h49,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h00,8'h00,8'h01,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h00,8'h00,8'h49,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h49,8'h01,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h49,8'h49,8'h49,8'h09,8'h49,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'hc8,8'h80,8'h80,8'hc0,8'hc0,8'hc0,8'hc0,8'h80,8'hc0,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h49,8'h49,8'h49,8'h49,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h80,8'h80,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h00,8'h00,8'h00,8'hda,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h01,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h01,8'h01,8'h01,8'h80,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc8,8'hc0,8'hc0,8'hc0,8'hc8,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h09,8'h09,8'h09,8'h09,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc9,8'h01,8'h51,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc8,8'hc0,8'hc0,8'hc0,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'h00,8'h01,8'hda,8'h91,8'h91,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h50,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'hc0,8'hc0,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'h00,8'h00,8'h91,8'h51,8'h51,8'h51,8'h51,8'h49,8'h00,8'h00,8'h00,8'h00,8'h50,8'h08,8'h08,8'h08,8'h51,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'hc0,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hc8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'h91,8'h90,8'h91,8'h91,8'h51,8'h51,8'h51,8'h51,8'h50,8'h48,8'h08,8'h08,8'h08,8'h08,8'h08,8'h49,8'h00,8'h00,8'h01,8'h01,8'h01,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc0,8'hc0,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hc8,8'h00,8'h91,8'h98,8'h90,8'h90,8'h91,8'h51,8'h51,8'h51,8'h51,8'h50,8'h48,8'h08,8'h08,8'h08,8'h08,8'h00,8'h00,8'h00,8'h01,8'h01,8'h01,8'h00,8'h00,8'h8a,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc8,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'h00,8'h99,8'h99,8'h99,8'h98,8'h90,8'h91,8'h51,8'h51,8'h51,8'h50,8'h50,8'h48,8'h08,8'h08,8'h49,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'h00,8'h99,8'h99,8'h99,8'h99,8'h90,8'h91,8'h91,8'h51,8'h51,8'h51,8'h50,8'h48,8'h08,8'h08,8'h08,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc0,8'hc8,8'hc8,8'hc8,8'hc8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd8,8'hd8,8'hd0,8'h00,8'h51,8'h99,8'h99,8'h99,8'h99,8'h99,8'h90,8'h91,8'h51,8'h51,8'h51,8'h50,8'h50,8'h48,8'h08,8'h09,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc8,8'hc0,8'hc8,8'hc8,8'hc8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd8,8'hd8,8'hd8,8'h00,8'h00,8'hda,8'h99,8'h99,8'h99,8'h99,8'h99,8'h99,8'h91,8'h91,8'h51,8'h51,8'h51,8'h50,8'h48,8'h51,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h49,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc8,8'hc0,8'hc8,8'hc8,8'hc0,8'hc0,8'hc0,8'hc0,8'hc0,8'hc8,8'hd8,8'hd8,8'hd8,8'hd8,8'h00,8'h00,8'hd9,8'hd9,8'h99,8'h99,8'h99,8'h99,8'h99,8'h90,8'h91,8'h51,8'h51,8'h51,8'h50,8'h48,8'h08,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h00,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hc8,8'hc0,8'h01,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'hc8,8'hd8,8'hd0,8'h01,8'h90,8'hd9,8'hd9,8'hd9,8'h99,8'h99,8'h99,8'h99,8'h98,8'h91,8'h51,8'h51,8'h51,8'h51,8'h48,8'h08,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h52,8'h53,8'h53,8'h53,8'h9b,8'h9b,8'h01,8'h01,8'h01,8'h01,8'hc8,8'h01,8'h91,8'hd9,8'hd9,8'hd9,8'h99,8'h99,8'h99,8'h99,8'h98,8'h90,8'h91,8'h51,8'h51,8'h50,8'h50,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h0a,8'h4a,8'h52,8'h52,8'h53,8'h53,8'h93,8'h9b,8'h9b,8'h9b,8'h9b,8'h01,8'h01,8'h01,8'h01,8'hda,8'hda,8'hd9,8'hd9,8'h99,8'h99,8'h99,8'h99,8'h99,8'h90,8'h91,8'h51,8'h51,8'h51,8'h51,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'hda,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h0a,8'h0a,8'h12,8'h52,8'h52,8'h53,8'h53,8'h93,8'h9b,8'h9b,8'h9b,8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h91,8'hd9,8'hd9,8'h99,8'h99,8'h99,8'h99,8'h99,8'h90,8'h91,8'h51,8'h51,8'h51,8'h49,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h0a,8'h0a,8'h12,8'h52,8'h52,8'h53,8'h53,8'h93,8'h9b,8'h9b,8'h9b,8'hFF,8'hFF,8'h93,8'h01,8'h01,8'h01,8'h01,8'h08,8'h99,8'h99,8'h99,8'h99,8'h99,8'h99,8'h90,8'h91,8'h90,8'h08,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h4a,8'h0a,8'h0a,8'h12,8'h52,8'h52,8'h53,8'h53,8'h93,8'h9b,8'h9b,8'h9b,8'h9b,8'hFF,8'h01,8'h01,8'hda,8'hda,8'h01,8'h01,8'h01,8'h01,8'h00,8'h08,8'h08,8'h08,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h09,8'h09,8'h09,8'h09,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h4a,8'h0a,8'h0a,8'h0a,8'h52,8'h52,8'h53,8'h53,8'h93,8'h9b,8'h9b,8'h9b,8'h9b,8'hFF,8'h01,8'h01,8'hda,8'hda,8'hda,8'hd9,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'hd1,8'hd0,8'h89,8'h01,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h52,8'h52,8'h53,8'h53,8'h93,8'h9b,8'h9b,8'h9b,8'h9b,8'h01,8'hd0,8'hda,8'hda,8'hda,8'hda,8'hda,8'hd9,8'hd9,8'hd0,8'hd0,8'hd0,8'hd8,8'hd8,8'hd0,8'hd0,8'h89,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h01,8'h01,8'h01,8'h01,8'h01,8'h92,8'hda,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h4a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h52,8'h52,8'h53,8'h53,8'h93,8'h93,8'h9b,8'h9b,8'h52,8'h01,8'hd9,8'hda,8'hda,8'hda,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'h01,8'h09,8'h09,8'h09,8'h0a,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h01,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'h92,8'h01,8'h01,8'h01,8'h09,8'h09,8'h09,8'h01,8'h01,8'h01,8'h4a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h52,8'h53,8'h53,8'h53,8'h93,8'h93,8'h9b,8'h01,8'h01,8'hda,8'hda,8'hda,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'h89,8'h09,8'h09,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h09,8'h09,8'h09,8'h01,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h09,8'h09,8'h09,8'h09,8'h09,8'h01,8'h01,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h52,8'h52,8'h53,8'h53,8'h53,8'h53,8'h93,8'h01,8'h01,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'h89,8'h09,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h09,8'h09,8'h01,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h01,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h52,8'h52,8'h52,8'h53,8'h53,8'h93,8'h01,8'hd0,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'h09,8'h09,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h09,8'h09,8'h01,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h4a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h52,8'h52,8'h52,8'h53,8'h01,8'h01,8'hda,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'h91,8'h09,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h01,8'h01,8'h92,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h09,8'h09,8'h09,8'h09,8'h09,8'h4a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h52,8'h52,8'h52,8'h09,8'h01,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'h89,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h09,8'h01,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h01,8'h01,8'h09,8'h09,8'h09,8'h09,8'h09,8'h0a,8'h4a,8'h0a,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h0a,8'h0a,8'h0a,8'h12,8'h53,8'h09,8'hd0,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h89,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h09,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h09,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h09,8'h0a,8'h09,8'h09,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h92,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h09,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h91,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h09,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hc8,8'h89,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h92,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h89,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hc8,8'hd0,8'hc8,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h89,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h12,8'h12,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'hc8,8'hc8,8'hd8,8'hd8,8'hd8,8'hc8,8'hc8,8'h09,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h92,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h12,8'h12,8'h12,8'h12,8'h52,8'h12,8'h12,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h12,8'h12,8'h12,8'h12,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h12,8'h12,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h12,8'h12,8'h52,8'h53,8'h53,8'h53,8'h53,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h12,8'h12,8'h12,8'h12,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h91,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h4a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h12,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h52,8'h12,8'h12,8'h12,8'h12,8'h12,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h0a,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h12,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h52,8'h52,8'h12,8'h12,8'h12,8'h12,8'h12,8'h0a,8'h0a,8'h0a,8'h0a,8'h92,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h0a,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h12,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h13,8'h12,8'h12,8'h12,8'h12,8'h0a,8'h0a,8'h0a,8'h92,8'h92,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h0a,8'h0a,8'h0a,8'h12,8'h12,8'h13,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h13,8'h12,8'h12,8'h0a,8'h0a,8'h4a,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h0a,8'h0a,8'h12,8'h12,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h13,8'h12,8'h12,8'h12,8'h0a,8'h92,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h49,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h92,8'h12,8'h12,8'h12,8'h13,8'h13,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h53,8'h13,8'h13,8'h13,8'h12,8'h12,8'h92,8'h92,8'h92,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h92,8'h12,8'h12,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h92,8'h92,8'h92,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h13,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'hd2,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h92,8'h92,8'h92,8'h92,8'h92,8'h92,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF}
};
`endif

// {Left, Top, Right, Bottom}
// Left 	- 3
// Top 		- 2
// Right 	- 1
// Bottom 	- 0
logic [0:3] [0:3] [3:0] hit_colors = 
{
	16'hC446,
	16'h8C62,
	16'h8932,
	16'h9113
};

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGB_smiley <= 8'h00;
		hitEdgeCode <= 4'h0;
	end

	else begin

		RGB_smiley <= TRANSPARENT_ENCODING;
		hitEdgeCode <= 4'h0;

		if (InsideRectangle == 1'b1) begin

`ifdef PICTURES
			RGB_smiley <= object_colors[OBJECT_HEIGHT_Y - offsetY][offsetX];
`else
			RGB_smiley <= 8'h55;
`endif

			hitEdgeCode <= hit_colors[offsetY >> OBJECT_HEIGHT_Y_DIVIDER][offsetX >> OBJECT_WIDTH_X_DIVIDER];
		end
	end

end

assign draw_smiley = (RGB_smiley != TRANSPARENT_ENCODING) ? 1'b1 : 1'b0;

endmodule
