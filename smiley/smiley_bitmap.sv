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

localparam  int OBJECT_NUMBER_OF_Y_BITS = 5;
localparam  int OBJECT_NUMBER_OF_X_BITS = 6;

localparam  int OBJECT_HEIGHT_Y = 1 <<  OBJECT_NUMBER_OF_Y_BITS;
localparam  int OBJECT_WIDTH_X = 1 <<  OBJECT_NUMBER_OF_X_BITS;

localparam  int OBJECT_HEIGHT_Y_DIVIDER = OBJECT_NUMBER_OF_Y_BITS - 2;
localparam  int OBJECT_WIDTH_X_DIVIDER =  OBJECT_NUMBER_OF_X_BITS - 2;

localparam logic [7:0] TRANSPARENT_ENCODING = 8'hFF;

// logic [0:OBJECT_HEIGHT_Y-1] [0:OBJECT_WIDTH_X-1] [7:0] object_colors = {
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hDB, 8'hFF, 8'hDF, 8'hDB, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFA, 8'hFA, 8'hF6, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFE, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hF6, 8'hFA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hF6, 8'hF5, 8'hF5, 8'hFA, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFA, 8'hFA, 8'hF5, 8'hF5, 8'hF5, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hD5, 8'hF5, 8'hF5, 8'hF9, 8'hF9, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hFA, 8'hF9, 8'hF9, 8'hF5, 8'hF5, 8'hF5, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hF1, 8'hF5, 8'hF5, 8'hF9, 8'hB1, 8'h6D, 8'h69, 8'h8D, 8'hD9, 8'hF9, 8'hFA, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFA, 8'hFA, 8'hFA, 8'hF9, 8'hF9, 8'hB5, 8'h6D, 8'h68, 8'h8D, 8'hD5, 8'hF5, 8'hF5, 8'hF0, 8'hD1, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hB6, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hF4, 8'hF5, 8'hF5, 8'hD5, 8'h8C, 8'h88, 8'hAC, 8'hAC, 8'hAC, 8'hAC, 8'hF9, 8'hFD, 8'hF9, 8'hFE, 8'hFA, 8'hFA, 8'hFE, 8'hFE, 8'hFA, 8'hF9, 8'hF9, 8'hF9, 8'hD5, 8'hAC, 8'hAC, 8'hAC, 8'h8C, 8'h68, 8'hB1, 8'hF5, 8'hF5, 8'hF4, 8'hF0, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hB6, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hD1, 8'hF4, 8'hF5, 8'hF5, 8'hF9, 8'hD0, 8'hF0, 8'hF0, 8'hF0, 8'hD0, 8'hF0, 8'hF0, 8'hF0, 8'hF9, 8'hFD, 8'hFA, 8'hFA, 8'hFE, 8'hFE, 8'hFE, 8'hFD, 8'hF9, 8'hF9, 8'hF5, 8'hF0, 8'hF0, 8'hD0, 8'hD0, 8'hF0, 8'hF0, 8'hD0, 8'hD4, 8'hF5, 8'hF5, 8'hF5, 8'hF0, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDA, 8'hB6, 8'hB6, 8'hB6, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD1, 8'hF0, 8'hF5, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hD0, 8'hAD, 8'h91, 8'h92, 8'h91, 8'h8D, 8'hD0, 8'hF4, 8'hF9, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFD, 8'hFD, 8'hF9, 8'hF0, 8'hAC, 8'h8D, 8'h92, 8'h92, 8'h91, 8'hAC, 8'hF0, 8'hF0, 8'hF4, 8'hF5, 8'hF5, 8'hF5, 8'hF0, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hDF, 8'hDB, 8'hDB, 8'hDB, 8'hB6, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hD5, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hD0, 8'h91, 8'hB6, 8'h6E, 8'h49, 8'h6E, 8'h92, 8'h92, 8'hD0, 8'hF9, 8'hFD, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFD, 8'hF4, 8'hAC, 8'hB6, 8'h92, 8'h49, 8'h49, 8'h92, 8'hB6, 8'hAD, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hD9, 8'hD9, 8'hDA, 8'hD6, 8'hD6, 8'hD6, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFA, 8'hFA, 8'hD5, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF4, 8'hB1, 8'h92, 8'h29, 8'h4E, 8'h25, 8'h01, 8'h05, 8'h72, 8'h91, 8'hF8, 8'hFD, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFD, 8'hD4, 8'hB2, 8'h4E, 8'h25, 8'h6E, 8'h25, 8'h01, 8'h49, 8'h92, 8'hD0, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hD5, 8'hFA, 8'hF9, 8'hF8, 8'hF8, 8'hF8, 8'hF4, 8'hF0, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hD9, 8'hF8, 8'hF4, 8'hD0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF4, 8'hB1, 8'h2A, 8'h4E, 8'hFF, 8'h92, 8'h00, 8'h05, 8'h2A, 8'h92, 8'hD8, 8'hFD, 8'hFE, 8'hFF, 8'hFF, 8'hFE, 8'hFE, 8'hFD, 8'hD4, 8'h92, 8'h05, 8'h6D, 8'hFB, 8'h6D, 8'h00, 8'h05, 8'h6E, 8'hB1, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hF4, 8'hF8, 8'hF8, 8'hF4, 8'hF4, 8'hF0, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hDA, 8'hF8, 8'hF8, 8'hF4, 8'hD0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF4, 8'hB1, 8'h2A, 8'h04, 8'h24, 8'h00, 8'h00, 8'h00, 8'h2A, 8'h91, 8'hF8, 8'hFD, 8'hFE, 8'hFF, 8'hFF, 8'hFE, 8'hFE, 8'hFD, 8'hD4, 8'h72, 8'h09, 8'h00, 8'h00, 8'h00, 8'h00, 8'h05, 8'h4E, 8'hD1, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF4, 8'hF0, 8'hF5, 8'hD6, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hD9, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hD4, 8'h52, 8'h05, 8'h00, 8'h00, 8'h25, 8'h05, 8'h4E, 8'hD5, 8'hFC, 8'hFD, 8'hFE, 8'hFE, 8'hFE, 8'hFE, 8'hFD, 8'hFD, 8'hF8, 8'hB5, 8'h2E, 8'h00, 8'h00, 8'h00, 8'h49, 8'h2A, 8'h71, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hD5, 8'hFA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFA, 8'hF4, 8'hF4, 8'hF0, 8'hD0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF8, 8'hB5, 8'h71, 8'h6D, 8'h6D, 8'hB1, 8'h92, 8'hB5, 8'hFC, 8'hFC, 8'hFD, 8'hFD, 8'hFE, 8'hFE, 8'hFE, 8'hFD, 8'hFD, 8'hFC, 8'hF8, 8'h95, 8'h71, 8'h6D, 8'h6D, 8'hB5, 8'h91, 8'hD4, 8'hF8, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hD5, 8'hD5, 8'hDA, 8'hD5, 8'hF0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF8, 8'hF4, 8'hF0, 8'hF1, 8'hF5, 8'hF5, 8'hF4, 8'hF8, 8'hF8, 8'hFC, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hF8, 8'hF8, 8'hF4, 8'hF1, 8'hF5, 8'hF5, 8'hF0, 8'hF4, 8'hF4, 8'hF8, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hD6, 8'hD5, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hF4, 8'hF4, 8'hF8, 8'hFC, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFC, 8'hF8, 8'hF8, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hD5, 8'hF5, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF8, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF8, 8'hF8, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hFD, 8'hF8, 8'hF8, 8'hF8, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hDA, 8'hD5, 8'hF9, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF8, 8'hD0, 8'h68, 8'h64, 8'h64, 8'h8C, 8'hD5, 8'hFA, 8'hFA, 8'hFA, 8'hF9, 8'hF9, 8'hFA, 8'hD9, 8'hB1, 8'h68, 8'h64, 8'h64, 8'h88, 8'hD4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF5, 8'hD5, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hD6, 8'hD5, 8'hF5, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF8, 8'hD0, 8'h64, 8'h20, 8'h20, 8'h20, 8'hB6, 8'hDB, 8'hDA, 8'hDA, 8'hDA, 8'hDA, 8'h69, 8'h20, 8'h20, 8'h40, 8'h8C, 8'hF4, 8'hF8, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF5, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hDF, 8'hDB, 8'hD6, 8'hD1, 8'hF5, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hF8, 8'hF8, 8'hAC, 8'h20, 8'h20, 8'h44, 8'h69, 8'h6D, 8'h6D, 8'h8D, 8'h69, 8'h20, 8'h20, 8'h44, 8'hD0, 8'hF8, 8'hF8, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF5, 8'hF5, 8'hD6, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDA, 8'hD1, 8'hF0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF8, 8'hAC, 8'h89, 8'hD2, 8'hF6, 8'hD2, 8'hCD, 8'hD6, 8'hF6, 8'hCE, 8'h89, 8'hD4, 8'hF8, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hF5, 8'hF6, 8'hDA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hDB, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hD6, 8'hD1, 8'hF0, 8'hF0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF5, 8'hF6, 8'hFB, 8'hF6, 8'hF2, 8'hFB, 8'hFA, 8'hF6, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF5, 8'hDA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hB6, 8'hDB, 8'hFA, 8'hF1, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF5, 8'hF1, 8'hF1, 8'hF1, 8'hF4, 8'hF4, 8'hF4, 8'hF4, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF5, 8'hD6, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hDB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFB, 8'hF6, 8'hF5, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF0, 8'hF1, 8'hF5, 8'hFA, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFA, 8'hFA, 8'hF6, 8'hF5, 8'hF5, 8'hF1, 8'hF1, 8'hF1, 8'hF1, 8'hF5, 8'hF5, 8'hF5, 8'hF6, 8'hFA, 8'hFB, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF },
// {8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF }
// };

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
			// RGB_smiley <= object_colors[OBJECT_HEIGHT_Y - offsetY][offsetX];
			RGB_smiley <= 8'h55;
			hitEdgeCode <= hit_colors[offsetY >> OBJECT_HEIGHT_Y_DIVIDER][offsetX >> OBJECT_WIDTH_X_DIVIDER];
		end
	end

end

assign draw_smiley = (RGB_smiley != TRANSPARENT_ENCODING) ? 1'b1 : 1'b0;

endmodule