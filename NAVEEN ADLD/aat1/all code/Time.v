//Design Code
module timer (
    input clk,
    input rst,
    input start,
    input [3:0] load_value,
    output reg [3:0] count,
    output reg done
);

always @(posedge clk) begin
    if (rst) begin
        count <= 4'b0000;
        done <= 1'b0;
    end
    else if (start) begin
        count <= load_value;
        done <= (load_value == 0);
    end
    else if (count > 0) begin
        if (count == 1) begin
            count <= 4'b0000;
            done <= 1'b1;
        end
        else begin
            count <= count - 1'b1;
        end
    end
end

endmodule

// Testbench Code


`timescale 1ns/1ps

module timer_tb;

reg clk;
reg rst;
reg start;
reg [3:0] load_value;

wire [3:0] count;
wire done;

timer uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .load_value(load_value),
    .count(count),
    .done(done)
);

// Generate clock with 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("timer.vcd");
    $dumpvars(0, timer_tb);

    $monitor("Time=%0t rst=%b start=%b count=%d done=%b",
             $time, rst, start, count, done);

    // Apply reset
    rst = 1;
    start = 0;
    load_value = 4'd5;

    @(negedge clk);
    rst = 0;

    // Start countdown from 5
    start = 1;

    @(negedge clk);
    start = 0;

    // Allow countdown to complete
    repeat (7) @(negedge clk);

    $finish;
end

endmodule