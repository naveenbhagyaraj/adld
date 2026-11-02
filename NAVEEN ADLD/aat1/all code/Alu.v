//Design Code
module alu (
    input [3:0] A,
    input [3:0] B,
    input [2:0] sel,
    output reg [3:0] Y
);

always @(*) begin
    case (sel)
        3'b000: Y = A + B;  // Addition
        3'b001: Y = A - B;  // Subtraction
        3'b010: Y = A & B;  // AND
        3'b011: Y = A | B;  // OR
        3'b100: Y = A ^ B;  // XOR
        3'b101: Y = ~A;     // NOT
        3'b110: Y = A << 1; // Left shift
        3'b111: Y = A >> 1; // Right shift
        default: Y = 4'b0000;
    endcase
end

endmodule


//Testbench Code`timescale 1ns/1ps

module alu_tb;

reg [3:0] A;
reg [3:0] B;
reg [2:0] sel;
wire [3:0] Y;

alu uut (
    .A(A),
    .B(B),
    .sel(sel),
    .Y(Y)
);

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);

    $display("A    B    sel  Y");
    $monitor("%b %b %b %b", A, B, sel, Y);

    A = 4'b1010;
    B = 4'b0011;

    sel = 3'b000; #10; // Addition
    sel = 3'b001; #10; // Subtraction
    sel = 3'b010; #10; // AND
    sel = 3'b011; #10; // OR
    sel = 3'b100; #10; // XOR
    sel = 3'b101; #10; // NOT
    sel = 3'b110; #10; // Left shift
    sel = 3'b111; #10; // Right shift

    $finish;
end

endmodule