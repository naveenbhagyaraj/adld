//Design Code
module divide_by_n (
    input clk,
    input rst,
    output reg clk_out
);

parameter N = 4;
integer count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        clk_out <= 0;
    end
    else begin
        if (count == (N/2)-1) begin
            count <= 0;
            clk_out <= ~clk_out;
        end
        else
            count <= count + 1;
    end
end

endmodule


//Testbench Code

module tb;

reg clk, rst;
wire clk_out;

divide_by_n uut (
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("divide_by_n.vcd");
    $dumpvars(0, tb);

    rst = 1;
    #10;

    rst = 0;
    #200;

    $finish;
end

initial begin
    $monitor("Time=%0t clk=%b rst=%b clk_out=%b",
             $time, clk, rst, clk_out);
end

endmodule