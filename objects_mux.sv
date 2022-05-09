module objects_mux(
	input		logic	clk,
	input		logic	resetN,
	input		logic	smileyDrawingRequest,
	input		logic	[7:0] smileyRGB,
	input		logic	[7:0] backGroundRGB,
	output	logic	[7:0] RGBOut
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		RGBOut <= 8'b0;
	end
	else begin
		if (smileyDrawingRequest == 1'b1)
			RGBOut <= smileyRGB;
		else 
			RGBOut <= backGroundRGB;
		end
	end

endmodule
