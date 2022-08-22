module edge_dectector(
	input	logic clk,
	input	logic resetN,
	input	logic startOfFrame,
	input	logic signal,
	output	logic edgeDetected
);

logic signal_previous;
assign edgeDetected = !signal_previous && signal;

always_ff @(posedge clk or negedge resetN)
begin

	if (!resetN) begin
		signal_previous <= 0;
	end
	else begin

		if (startOfFrame)
			signal_previous <= 0;

		if (signal)
			signal_previous <= 1;

	end

end

endmodule
