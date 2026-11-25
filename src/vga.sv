module vga (
    output logic red, green, blue, vsync, hsync,
    input wire clk
);
    // Horizontal timings
    localparam  H_VISIBLE = 640,
                H_FPORCH = 16,
                H_SYNC = 96,
                H_BPORCH = 48,
                H_WHOLE_LINE = H_VISIBLE + H_FPORCH + H_SYNC + H_BPORCH;

    // Vertical timings
    localparam  V_VISIBLE = 480,
                V_FPORCH = 10,
                V_SYNC = 2,
                V_BPORCH = 33,
                V_WHOLE_LINE = V_VISIBLE + V_FPORCH + V_SYNC + V_BPORCH;

    // Pixel counters + state
    // 00 = visible, 01 = front porch, 10 = sync, 11 = back porch
    logic [9:0] h_counter,
                v_counter;
    logic [1:0] h_state,
                v_state;

    always_ff @(posedge clk) begin
		h_counter++;

        // Horizontal
        case (h_counter)
            H_VISIBLE: h_state = 2'b01;
            H_VISIBLE + H_FPORCH: h_state = 2'b10;
            H_VISIBLE + H_FPORCH + H_SYNC: h_state = 2'b11;
            H_WHOLE_LINE: begin
                h_state = 2'b00;
                h_counter = 0;
                v_counter++;
            end
        endcase

        // Vertical
        case (v_counter)
            V_VISIBLE: v_state = 2'b01;
            V_VISIBLE + V_FPORCH: v_state = 2'b10;
            V_VISIBLE + V_FPORCH + V_SYNC: v_state = 2'b11;
            V_WHOLE_LINE: begin
                v_state = 2'b00;
                v_counter = 0;
            end
        endcase
	end

    // Ensure output is disabled in porch regions
    logic rgb_enabled = (h_state == 2'b00) && (v_state == 2'b00);

    assign hsync = h_state != 2'b10;
    assign vsync = v_state != 2'b10;

    assign red = (h_counter < 320) && rgb_enabled;
    assign green = (v_counter[4] & h_counter[4]) && rgb_enabled;
    assign blue = (v_counter < 240) && rgb_enabled;
endmodule