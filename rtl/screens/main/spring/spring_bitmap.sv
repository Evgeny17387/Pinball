import defines::COLOR_TRANSPARENT, defines::COLOR_RED;

module spring_bitmap(
    input   logic	        clk,
    input	logic	        resetN,
    input   logic	[10:0]  offsetX,
    input   logic	[10:0]  offsetY,
    input	logic	        insideRectangle,
    output	logic	        drawSpring,
    output	logic	[7:0]   RGBSpring
);

always_ff@(posedge clk or negedge resetN) 
begin 

	if(!resetN) begin 
		RGBSpring <= 8'h00;
	end 
	else begin 
		RGBSpring <= COLOR_TRANSPARENT;

		if (insideRectangle == 1'b1)
		begin
			RGBSpring <= COLOR_RED;
		end

	end

end

assign drawSpring = (RGBSpring != COLOR_TRANSPARENT ) ? 1'b1 : 1'b0;

endmodule
