import defines::COLOR_TRANSPARENT;

module bumper_bitmap(
    input   logic	        clk,
    input	logic	        resetN,
    input   logic	[10:0]  offsetX,
    input   logic	[10:0]  offsetY,
    input	logic	        insideRectangle,
    output	logic	        drawBumper,
    output	logic	[7:0]   RGBBumper
);

logic[0:31][0:63][7:0] object_colors = {
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h40,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h49,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h89,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hda,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'hd0,8'hd8,8'h91,8'h92,8'h51,8'h49,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h40,8'h48,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'hd0,8'hd9,8'h92,8'hFF,8'h00,8'h92,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'hd0,8'hda,8'hd9,8'h92,8'h92,8'h91,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'hd8,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd9,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'hd0,8'hd9,8'hd9,8'hd9,8'hd8,8'hd0,8'hd9,8'hd0,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd9,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd0,8'hd8,8'hd0,8'hd0,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd8,8'hd0,8'hd9,8'hda,8'hd9,8'hd9,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd9,8'hd9,8'hd9,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd9,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd9,8'hd0,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd9,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hda,8'h00,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd9,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd0,8'hd8,8'hd8,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd8,8'hd9,8'hd9,8'hd9,8'hda,8'hd9,8'hd9,8'hd9,8'hd8,8'hd9,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd8,8'hd9,8'hda,8'hda,8'hda,8'hda,8'hda,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd9,8'hda,8'hda,8'hda,8'hda,8'hda,8'hd9,8'hd9,8'hd8,8'hd8,8'hd8,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'h49,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h48,8'hd0,8'hd9,8'hda,8'hda,8'hda,8'hda,8'hd9,8'hd9,8'hd8,8'hd0,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd8,8'hda,8'hda,8'hda,8'hda,8'hd9,8'hd9,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'hd0,8'hd9,8'hda,8'hda,8'hd9,8'hd9,8'hd9,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h48,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd0,8'hd9,8'hd9,8'hd9,8'hd9,8'hd8,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd8,8'hd9,8'hd8,8'hd8,8'hd0,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h40,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h92,8'h92,8'h49,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h91,8'h92,8'h00,8'h92,8'h88,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hda},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h89,8'h00,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h92,8'h92,8'h9b,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h88,8'hd8,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'hd0,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF},
	{8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF,8'hFF}
};

always_ff@(posedge clk or negedge resetN) 
begin 

	if(!resetN) begin 
		RGBBumper <= 8'h00;
	end 
	else begin 
		RGBBumper <= COLOR_TRANSPARENT;

		if (insideRectangle == 1'b1)
		begin
			RGBBumper <= object_colors[offsetY][offsetX];
		end

	end

end

assign drawBumper = (RGBBumper != COLOR_TRANSPARENT ) ? 1'b1 : 1'b0;

endmodule
