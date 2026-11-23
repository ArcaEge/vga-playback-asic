`include "../src/project.sv"

module top (
	output logic [4:0] led,
	input  wire        clk
);
    // I/O
    wire [7:0] ui_in;
    wire [7:0] uo_out;
    wire [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    wire ena;
    wire clki;
    wire rst_n;
	
    clock clck (.clk, .clki);

    assign led = uo_out[4:0];

    tt_um_arcaege_vgaplay project (.ui_in, .uo_out, .uio_in, .uio_out, .uio_oe, .ena, .clk(clki), .rst_n);
endmodule

module clock (input wire clk, output wire clki);
    // Clock (50MHz >> 1 = 25MHz)
	logic [1:0] clkb;
	assign clki = clkb[1];

	// Count the clocks
	always @(posedge clk) clkb <= clkb + 1'b1;

	initial begin
		clkb = 0;
	end
endmodule