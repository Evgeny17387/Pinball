module counter
(
	input   logic		    clk,
	input   logic		    resetN,
	output  logic   [3:0]   counter
);

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

        counter <= 0;

    end
	else begin

        counter <= counter + 1;

	end

end 

endmodule
