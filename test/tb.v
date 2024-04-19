`default_nettype none

`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/

module tb ();

// Dump the signals to a VCD file. You can view it with gtkwave.
initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
end

// Wire up the inputs and outputs:
reg [7:0] out;
reg [7:0] ui_in;    // Dedicated inputs
reg [7:0] uo_out;   // Dedicated outputs
reg [7:0] uio_in;   // IOs: Input path
reg [7:0] uio_out;  // IOs: Output path
reg [7:0] uio_oe;   // IOs: Enable path (active high: 0=input, 1=output)
reg       ena;      // will go high when the design is enabled
reg       clk;	    // clock
reg       rst_n;     // reset_n - low to reset

// Replace counter_module with your module name:
tt_um_bit_ctrl user_project (
	// Include power ports for the Gate Level test:
	`ifdef GL_TEST
	.VPWR(1'b1),
	.VGND(1'b0),
	`endif
	.ui_in  (ui_in),    // Dedicated inputs
	.uo_out (uo_out),   // Dedicated outputs
	.uio_in (uio_in),   // IOs: Input path
	.uio_out(uio_out),  // IOs: Output path
	.uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
	.ena    (ena),      // enable - goes high when design is selected
	.clk    (clk),      // clock
	.rst_n  (rst_n)     // not reset
);

endmodule
