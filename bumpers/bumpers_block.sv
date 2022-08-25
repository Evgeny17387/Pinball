import defines::BUMPER_COLOR;
import defines::SCREEN_MAIN_BUMPER_WIDTH, defines::SCREEN_MAIN_BUMPER_HEIGHT;
import defines::SCREEN_MAIN_BUMPERS_ORIENTATION, defines::SCREEN_MAIN_BUMPERS_TOP_LEFT_X, defines::SCREEN_MAIN_BUMPERS_TOP_LEFT_Y;
import defines::NUM_BUMPERS;
import defines::SCREEN_MAIN_BUMPERS_COLLISION_FACTOR;

module bumpers_block(
	input	logic					clk,
	input	logic					resetN,
	input 	logic 			[10:0] 	pixelX,
	input 	logic 			[10:0] 	pixelY,
	output	logic			[7:0]	RGBBumper,
	output 	logic 					drawBumper,
	output	COLLISION_FACTOR		collisionFactor
);

logic drawTriangle[NUM_BUMPERS];

genvar i;
generate
    for (i = 0; i < NUM_BUMPERS; i = i + 1) begin : block_triangle_inst
		triangle #(
			.OBJECT_WIDTH(SCREEN_MAIN_BUMPER_WIDTH),
			.OBJECT_HEIGHT(SCREEN_MAIN_BUMPER_HEIGHT),
			.TOP_LEFT_X(SCREEN_MAIN_BUMPERS_TOP_LEFT_X[i]),
			.TOP_LEFT_Y(SCREEN_MAIN_BUMPERS_TOP_LEFT_Y[i]),
			.ORIENTATION(SCREEN_MAIN_BUMPERS_ORIENTATION[i])) triangle_inst_0(
		// input
			.pixelX(pixelX),
			.pixelY(pixelY),
		// output
			.draw(drawTriangle[i])
		);
    end
endgenerate

logic [7:0] RGBTriangle[NUM_BUMPERS];

genvar j;
generate
    for (j = 0; j < NUM_BUMPERS; j = j + 1) begin : block_object_inst
		object #(.COLOR(BUMPER_COLOR)) object_inst_0(
		// input
			.clk(clk),
			.resetN(resetN),
			.insideObject(drawTriangle[j]),
		// output
			.RGBObject(RGBTriangle[j])
		);
    end
endgenerate

assign drawBumper = drawTriangle.or();

always_comb begin
	RGBBumper = RGBTriangle[0];
	collisionFactor = SCREEN_MAIN_BUMPERS_COLLISION_FACTOR[0];

    for (byte i = 1; i < NUM_BUMPERS; i = i + 1) begin
        if (drawTriangle[i]) begin
			case(i)
			1: begin
				RGBBumper = RGBTriangle[1];
				collisionFactor = SCREEN_MAIN_BUMPERS_COLLISION_FACTOR[1];
			end
			2: begin
				RGBBumper = RGBTriangle[2];
				collisionFactor = SCREEN_MAIN_BUMPERS_COLLISION_FACTOR[2];
			end
			endcase
        end
    end
end

endmodule
