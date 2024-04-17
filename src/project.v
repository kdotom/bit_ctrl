`default_nettype none
`timescale 1ns/1ns
module tt_um_bit_ctrl (
    input wire clk,
    input wire reset,
    output reg [7:0] out
);

reg [2:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
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
