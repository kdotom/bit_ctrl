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
reg clk;
reg reset;
wire [7:0] out;

// Replace counter_module with your module name:
tt_um_bit_ctrl user_project (
    // Include power ports for the Gate Level test:
    `ifdef GL_TEST
    .VPWR(1'b1),
    .VGND(1'b0),
    `endif
    .clk(clk),    // Clock
    .reset(reset),// Reset
    .out(out)     // IOs: Output path
);

endmodule
