//Design Code
module random_sequence (
    input clk,
    input rst,
    output reg [3:0] Q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        Q <= 4'b0001;
    else
        Q <= {Q[2:0], Q[3] ^ Q[2]};
end

endmodule


//Testbench Code

module tb;

reg clk, rst;
wire [3:0] Q;

random_sequence uut (
    .clk(clk),
    .rst(rst),
    .Q(Q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("random_sequence.vcd");
    $dumpvars(0, tb);

    rst = 1;
    #10;

    rst = 0;
    #160;

    $finish;
end

initial begin
    $monitor("Time=%0t clk=%b rst=%b Q=%b",
             $time, clk, rst, Q);
end

endmodule