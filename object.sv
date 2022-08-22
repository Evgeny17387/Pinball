import defines::COLOR_TRANSPARENT;

module object
#(parameter COLOR)
(
    input   logic	        clk,
    input	logic	        resetN,
    input	logic	        insideObject,
    output	logic	[7:0]   RGBObject
);

always_ff@(posedge clk or negedge resetN) 
begin 

	if(!resetN) begin 
		RGBObject <= 8'h00;
	end 
	else begin 
		RGBObject <= COLOR_TRANSPARENT;

		if (insideObject == 1'b1)
		begin
			RGBObject <= COLOR;
		end

	end

end

endmodule
