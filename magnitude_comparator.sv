/*Design a parameterized magnitude comparator. Given inputs a and b, output three flags: eq
(a==b), gt (a>b), lt (a<b). Support both unsigned and signed comparison via a parameter.*/

module mag_comparator
#(
    parameter WIDTH = 8,
    parameter SIGNED = 0
)
(
    input  [WIDTH-1:0] a,
    input  [WIDTH-1:0] b,
    output reg eq,
    output reg gt,
    output reg lt
);

always @(*) begin
    // Default values
    eq = 1'b0;
    gt = 1'b0;
    lt = 1'b0;

    if (SIGNED) begin
        if ($signed(a) > $signed(b))
            gt = 1'b1;
        else if ($signed(a) < $signed(b))
            lt = 1'b1;
        else
            eq = 1'b1;
    end
    else begin
        if (a > b)
            gt = 1'b1;
        else if (a < b)
            lt = 1'b1;
        else
            eq = 1'b1;
    end
end

endmodule
