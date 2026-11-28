module qspi (
    output wire [3:0] qspi_io_out,
    input wire [3:0] qspi_io_in,
    output wire qspi_cs, qspi_clk, qspi_oe,
    input wire clk
);
    assign qspi_io_out = 'b1010;
    assign qspi_cs = 1;
    assign qspi_oe = 1;
    assign qspi_clk = clk;

    logic state = 0;

    
endmodule