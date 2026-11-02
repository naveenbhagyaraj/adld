//Design Code
module sync_counter (
    input clk,
    input rst,
    output reg [3:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 4'b0000;
    else
        q <= q + 1'b1;
end

endmodule


// Testbench Code
module tb;

reg clk, rst;
wire [3:0] q;

sync_counter uut (
    .clk(clk),
    .rst(rst),
    .q(q)
);

initial begin
    $dumpfile("sync_counter.vcd");
    $dumpvars(0, tb);

    clk = 0;
    rst = 1;

    #10;
    rst = 0;

    #160;

    $finish;
end

always #5 clk = ~clk;

initial begin
    $monitor("Time=%0t clk=%b rst=%b q=%b",
             $time, clk, rst, q);
end

endmodule