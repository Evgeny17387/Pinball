module main(
	output	logic [28:0] 	OVGA,
	input		logic				resetN,
	input		logic				CLOCK_50,
	input		logic	[3:1]		KEY
);

logic				clk;
logic				reset;

logic	[10:0]	PixelX;
logic	[10:0]	PixelY;

logic	[7:0]		backGroundRGB;
logic	[7:0]		smileyRGB;
logic	[7:0]		RGB;

logic				boardersDrawReq;
logic 			smileyDrawingRequest;

logic 			startOfFrame;
logic 			Y_direction;
logic				toggleX;
logic				collision;

assign reset = !resetN;

assign Y_direction	= KEY[1];
assign toggleX 		= KEY[2];

back_ground_draw back_ground_draw_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(PixelX),
	.pixelY(PixelY),
// output
	.BG_RGB(backGroundRGB),
	.boardersDrawReq(boardersDrawReq)
);

smiley_block smiley_block_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.pixelX(PixelX),
	.pixelY(PixelY),
	.startOfFrame(startOfFrame),
	.Y_direction(Y_direction),
	.toggleX(toggleX),
	.collision(collision),
// output
	.RGBout(smileyRGB),
	.smileyDrawingRequest(smileyDrawingRequest)
);

objects_mux objects_mux_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.smileyDrawingRequest(smileyDrawingRequest),
	.smileyRGB(smileyRGB),
	.backGroundRGB(backGroundRGB),
// output
	.RGBOut(RGB)
);

clock_divider_0002 clock_divider_inst(
	.refclk(CLOCK_50),
	.rst(reset),
	.outclk_0(clk),
);

VGA_Controller VGA_Controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.RGBIn(RGB),
// output
	.PixelX(PixelX),
	.PixelY(PixelY),
	.oVGA(OVGA),
	.startOfFrame(startOfFrame)
);

game_controller game_controller_inst(
// input
	.clk(clk),
	.resetN(resetN),
	.drawing_request_Ball(smileyDrawingRequest),
	.drawing_request_1(boardersDrawReq),
// output
	.collision(collision)
);

endmodule
