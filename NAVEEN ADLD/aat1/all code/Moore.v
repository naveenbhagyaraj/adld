//Design Code
module moore_detector(
    input clk,
    input reset,
    input din,
    output reg detected
);

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100;

reg [2:0] state, next_state;

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

// Next-state logic
always @(*) begin
    case (state)
        S0: next_state = din ? S1 : S0;
        S1: next_state = din ? S1 : S2;
        S2: next_state = din ? S3 : S0;
        S3: next_state = din ? S4 : S2;
        S4: next_state = din ? S1 : S2;
        default: next_state = S0;
    endcase
end

// Moore output logic
always @(*) begin
    detected = (state == S4);
end

endmodule


//Testbench Code
`timescale 1ns/1ps

module tb_moore_detector;

reg clk, reset, din;
wire detected;

moore_detector uut (
    .clk(clk),
    .reset(reset),
    .din(din),
    .detected(detected)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Input sequence: 1011011
initial begin
    reset = 1;
    din = 0;

    repeat (2) @(negedge clk);
    reset = 0;

    @(negedge clk); din = 1;
    @(negedge clk); din = 0;
    @(negedge clk); din = 1;
    @(negedge clk); din = 1;
    @(negedge clk); din = 0;
    @(negedge clk); din = 1;
    @(negedge clk); din = 1;

    @(negedge clk);
    $finish;
end

// Generate waveform file
initial begin
    $dumpfile("moore_wave.vcd");
    $dumpvars(0, tb_moore_detector);
end

endmodule