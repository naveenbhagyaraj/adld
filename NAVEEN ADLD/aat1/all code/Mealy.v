//Design Code
module mealy_detector(
    input clk,
    input reset,
    input din,
    output reg detected
);

parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

reg [1:0] state, next_state;

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

// Next-state and output logic
always @(*) begin
    next_state = S0;
    detected = 0;

    case (state)
        S0: begin
            if (din)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (din)
                next_state = S1;
            else
                next_state = S2;
        end
        S2: begin
            if (din)
                next_state = S3;
            else
                next_state = S0;
        end
        S3: begin
            if (din) begin
                detected = 1;
                next_state = S1;
            end
            else
                next_state = S2;
        end
        default: begin
            next_state = S0;
            detected = 0;
        end
    endcase
end

endmodule


//Testbench Code

`timescale 1ns/1ps

module tb_mealy_detector;

reg clk, reset, din;
wire detected;

mealy_detector uut (
    .clk(clk),
    .reset(reset),
    .din(din),
    .detected(detected)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

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

initial begin
    $dumpfile("mealy_wave.vcd");
    $dumpvars(0, tb_mealy_detector);
end

endmodule