module key_decoder(
	input	 logic      clk,
	input	 logic      resetN,
	input  logic[8:0]	key_code,
	input  logic 	   make,
	input  logic 	   breakk,
	output logic  		keyLatch,
	output logic  		keyRisingEdgePulse,
	output logic  		keyIsPressed
);

parameter KEY_VALUE = 9'h070;

logic keyIsPressed_d;

assign keyRisingEdgePulse = (keyIsPressed_d == 1'b0) && (keyIsPressed == 1'b1);

always_ff @(posedge clk or negedge resetN)
begin: fsm_sync_proc

	if (resetN == 1'b0) begin
		keyIsPressed_d <= 0;
		keyIsPressed  <= 0;
		keyLatch <= 0;
	end

	else begin

		if (key_code == KEY_VALUE) begin
				if (make == 1'b1) begin
					keyIsPressed <= 1'b1;
				end
				else if (breakk == 1'b1) begin
					keyIsPressed <= 1'b0;
				end
		end

		keyIsPressed_d <= keyIsPressed;

		keyLatch <= (keyRisingEdgePulse) ? ~keyLatch : keyLatch;

	end

end

endmodule
