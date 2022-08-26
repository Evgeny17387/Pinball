module one_sec_counter(
    input   logic	clk,
    input	logic	resetN,
	output	logic	oneSecPulse
);

int counter;

always_ff@(posedge clk or negedge resetN) 
begin 

	if(!resetN) begin 

		counter <= 0;

	end 
	else begin 

		if (counter == 25000000) begin
			oneSecPulse <= 1'b1;
			counter <= 0;
		end else begin
			oneSecPulse <= 1'b0;
			counter <= counter + 1;
		end

	end

end

endmodule
