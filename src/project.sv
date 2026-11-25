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

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[7:0] = 0;
  assign uio_oe  = 0;

  wire vsync, hsync, blue, green, red;
  assign uo_out[7:0] = {3'b000, vsync, hsync, blue, green, red};

  // Add one to the led register
	always_ff @(posedge clk) begin
		// led <= led + 1;
	end

  vga display (.red, .green, .blue, .hsync, .vsync, .clk);

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, rst_n, 1'b0};

endmodule
