//Design Code
module parity (
    input [3:0] data,
    input parity_in,
    output reg parity_out,
    output reg error
);

always @(*) begin

    // Even parity generator
    parity_out = ^data;

    // Parity checker
    if ((^data) == parity_in)
        error = 1'b0;
    else
        error = 1'b1;

end

endmodule


//Testbench Code
module tb;

reg [3:0] data;
reg parity_in;
wire parity_out;
wire error;

parity uut (
    .data(data),
    .parity_in(parity_in),
    .parity_out(parity_out),
    .error(error)
);

initial begin
    $dumpfile("parity.vcd");
    $dumpvars(0, tb);

    data = 4'b0000; parity_in = 0;
    #10; data = 4'b0001; parity_in = 1;
    #10;
    data = 4'b0011; parity_in = 0;
    #10; data = 4'b1010; parity_in = 0;
    #10;
    data = 4'b1010; parity_in = 1;
    #10;

    $finish;
end

initial begin
    $monitor("Time=%0t data=%b parity_in=%b parity_out=%b error=%b",
             $time, data, parity_in, parity_out, error);
end

endmodule

