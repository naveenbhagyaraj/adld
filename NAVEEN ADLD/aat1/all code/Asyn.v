//Design Code
module async_counter (
    input clk,
    input rst,
    output reg [3:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q[0] <= 1'b0;
    else
        q[0] <= ~q[0];
end

always @(posedge q[0] or posedge rst) begin
    if (rst)
        q[1] <= 1'b0;
    else
        q[1] <= ~q[1];
end

always @(posedge q[1] or posedge rst) begin
    if (rst)
        q[2] <= 1'b0;
    else
        q[2] <= ~q[2];
end

always @(posedge q[2] or posedge rst) begin
    if (rst)
        q[3] <= 1'b0;
    else
        q[3] <= ~q[3];
end

endmodule


//testbench Code
module tb;

reg clk, rst;
wire [3:0] q;

async_counter uut (
    .clk(clk),
    .rst(rst),
    .q(q)
);

initial begin
    $dumpfile("async_counter.vcd");
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
