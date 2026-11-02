//Design code

module comp_n #(
    parameter N=4
)(
    input [N-1:0]a,b,
    output reg agb,alb,aeb
);

always@(*) begin
    if(a>b)
    begin
        agb=1;
        aeb=0;
        alb=0;
    end

    else if(a<b)
    begin
        agb=0;
        aeb=0;
        alb=1;
    end

    else
    begin
        agb=0;
        aeb=1;
        alb=0;
    end
end

endmodule


//testbench code
module comp_tb;

reg [3:0] a,b;
wire agb,alb,aeb;

comp_n c1(a,b,agb,alb,aeb);

initial begin
    a=4'b1101;b=4'b0001;
    #10 a=4'b0100;b=4'b1000;
    #10 a=4'b0011;b=4'b0011;
    #10 $finish;
end

initial begin
    $dumpfile("comp.vcd");
    $dumpvars;
end

endmodule