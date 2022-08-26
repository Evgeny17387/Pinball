module random_number
(
	input   logic		    clk,
	input   logic		    resetN,
    input   logic           getRandomNumber,
	output  logic   [3:0]   randomNumber
);

logic [3:0] counter;

always_ff@(posedge clk or negedge resetN)
begin

	if (!resetN) begin

        counter <= 0;

        randomNumber <= 0;

    end
	else begin

        if (counter == 9) begin

            counter <= 0;

        end
        else begin

            counter <= counter + 1;

        end

        if (getRandomNumber) begin
            
            randomNumber = counter;

        end

	end

end 

endmodule
