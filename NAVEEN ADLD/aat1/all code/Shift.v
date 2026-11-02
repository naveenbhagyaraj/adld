//Design Code
module shift_register (
    input clk,
    input rst,
    input [1:0] mode,
    input [3:0] D,
    input SR,
    input SL,
    output reg [3:0] Q
);
always @(posedge clk) begin
    if (rst)
        Q <= 4'b0000;
    else begin
        case (mode)
            2'b00: Q <= Q;               // Hold
            2'b01: Q <= {SR, Q[3:1]};    // Shift right
            2'b10: Q <= {Q[2:0], SL};    // Shift left
            2'b11: Q <= D;               // Parallel load
            default: Q <= Q;
        endcase
    end
end

endmodule



//Testbench Code
`timescale 1ns/1ps

module shift_register_tb;

reg clk;
reg rst;
reg [1:0] mode;
reg [3:0] D;
reg SR, SL;
wire [3:0] Q;

shift_register uut (
    .clk(clk),
    .rst(rst),
    .mode(mode),
    .D(D),
    .SR(SR),
    .SL(SL),
    .Q(Q)
);

// Generate clock with 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("shift_register.vcd");
    $dumpvars(0, shift_register_tb);

    $monitor("Time=%0t rst=%b mode=%b D=%b SR=%b SL=%b Q=%b",
             $time, rst, mode, D, SR, SL, Q);

    // Reset
    rst = 1;
    mode = 2'b00;
    D = 4'b0000;
    SR = 0;
    SL = 0;
    #10;

    // Parallel load 1011
    rst = 0;
    mode = 2'b11;
    D = 4'b1011;
    #10;

    // Hold data
    mode = 2'b00;
    #10;

    // Shift right, insert 0
    mode = 2'b01;
    SR = 0;
    #10;

    // Shift left, insert 1
    mode = 2'b10;
    SL = 1;
    #10;

    // Parallel load 1100
    mode = 2'b11;
    D = 4'b1100;
    #10;

    $finish;
end

endmodule