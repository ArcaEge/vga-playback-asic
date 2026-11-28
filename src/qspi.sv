module qspi (
    output wire [3:0] qspi_io_out,
    input wire [3:0] qspi_io_in,
    output wire [3:0] qspi_oe,
    output wire qspi_cs, qspi_clk,
    input wire clk
);
    wire ready;
    logic state = 0;

    assign qspi_io_out[0] = 0;
    assign qspi_cs = 1;
    assign qspi_oe = 'b11;
    assign qspi_clk = clk;

    qspi_startup_delay delay (.clk, .ready);
endmodule

// Delay ~10ms to wait for flash IC to be ready
module qspi_startup_delay (
    input wire clk,
    output wire ready
);
    // Ready when counter wraps around
    logic [19:0] counter = 'b1;
    assign ready = counter[19];

    always_ff @(posedge clk) begin
        if (!ready) counter <= counter + 1;
    end
endmodule