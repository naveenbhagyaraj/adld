//Design Code
module n_bit_comparator #(parameter N = 4) (
    input [N-1:0] A,
    input [N-1:0] B,
    output reg GT,
    output reg LT,
    output reg EQ
);

always @(*) begin
    if (A > B) begin
        GT = 1'b1;
        LT = 1'b0;
        EQ = 1'b0;
    end
    else if (A < B) begin
        GT = 1'b0;
        LT = 1'b1;
        EQ = 1'b0;
    end
    else begin
        GT = 1'b0;
        LT = 1'b0;
        EQ = 1'b1;
    end
end

endmodule
//Testbench Code
