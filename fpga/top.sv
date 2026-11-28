`include "../src/project.sv"

module top (
	output logic [4:0] led,
    output wire red, green, blue, vsync, hsync,
    inout wire [3:0] qspi_io,
    output wire qspi_cs,
    output wire qspi_clk,
	input  wire clk
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

    // VGA
    assign {vsync, hsync, blue, green, red} = uo_out[4:0];

    // QSPI
    assign qspi_clk = uo_out[6];
    assign qspi_cs = uo_out[5];
    assign uio_in[3:0] = qspi_io;
    genvar i;
    generate
        for (i = 0; i <= 3; i++) begin : g_qspi_io
            assign qspi_io[i] = uio_oe[i] ? uio_out[i] : 'z;
        end
    endgenerate
	
    // clock clck (.clk, .clki);
    assign clki = clk;

    assign led = 5'b0;

    tt_um_arcaege_vgaplay project (.ui_in, .uo_out, .uio_in, .uio_out, .uio_oe, .ena, .clk(clki), .rst_n);
endmodule

// // Clock (50MHz >> 1 = 25MHz)
// module clock (input wire clk, output logic clki);
// 	// Count the clocks
// 	always @(posedge clk) clki = clki + 1'b1;

// 	initial begin
// 		clki = 0;
// 	end
// endmodule