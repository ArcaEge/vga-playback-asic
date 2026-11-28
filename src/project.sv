/*
 * Copyright (c) 2026 Arca Cengiz
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none
`include "./vga.sv"

module tt_um_arcaege_vgaplay (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
  // Signal wires
  wire vsync, hsync, blue, green, red;
  wire qspi_cs, qspi_clk, qspi_oe;
  wire [3:0] qspi_io_out, qspi_io_in;

  // Map wires to pins
  assign uo_out = {1'b0, qspi_clk, qspi_cs, vsync, hsync, blue, green, red};
  assign uio_out = {4'b0, qspi_io_out};
  assign uio_oe = {4'b0, {4{qspi_oe}}};
  assign qspi_io_in = uio_in[3:0];

  // Add one to the led register
	always_ff @(posedge clk) begin
		// led <= led + 1;
	end

  vga display (.red, .green, .blue, .hsync, .vsync, .clk);

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, rst_n, 1'b0};

endmodule
