`default_nettype none
`timescale 1ns/1ns
module tt_um_bit_ctrl (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire reset;
reg [7:0] out;
reg [2:0] counter;

//assign clk = ui_in[0];
//assign reset = !(rst_n);
assign uo_out = out;
assign uio_oe  = 0;
assign uio_out = 0;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 3'b000;
    end else begin
        if (counter < 3'b101) begin
            counter <= counter + 1;
        end else begin
            counter <= 3'b000;
        end
    end
end

always @(*) begin
    case (counter)
        3'b000: out = 8'b10010000;
        3'b001: out = 8'b00011000;
        3'b010: out = 8'b01001000;
        3'b011: out = 8'b01100000;
        3'b100: out = 8'b00100100;
        3'b101: out = 8'b10000100;
        default: out = 8'b00000000;
    endcase
end

endmodule
