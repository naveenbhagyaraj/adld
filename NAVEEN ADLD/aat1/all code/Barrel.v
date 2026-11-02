// Design Code
module barrel_shifter (
    input [3:0] w,
    input [1:0] sel,
    output reg [3:0] y
);
always @(*) begin
    case (sel)
        2'b00: y = w;
        2'b01: y = {w[0], w[3], w[2], w[1]};
        2'b10: y = {w[1], w[0], w[3], w[2]};
        2'b11: y = {w[2], w[1], w[0], w[3]};
    endcase
end

endmodule


//Testbench Code
module tb;

reg [3:0] w;
reg [1:0] sel;
wire [3:0] y;

barrel_shifter dut (
    .w(w),
    .sel(sel),
    .y(y)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    w = 4'b1010; sel = 2'b00; #10;
    w = 4'b1010; sel = 2'b01; #10;
    w = 4'b1010; sel = 2'b10; #10;
    w = 4'b1010; sel = 2'b11; #10;

    w = 4'b1101; sel = 2'b00; #10;
    w = 4'b1101; sel = 2'b01; #10;
    w = 4'b1101; sel = 2'b10; #10;
    w = 4'b1101; sel = 2'b11; #10;

    $finish;
end

endmodule