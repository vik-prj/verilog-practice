/* Design a parameterized even/odd parity generator. Also design a parity checker that asserts
an error flag when received data parity does not match the expected parity bit. */

module even_odd_parity #(parameter WIDTH = 8, parameter ODD = 0)
(
    input  [WIDTH-1:0] data,
    output parity
);

assign parity = (ODD) ? ~(^data) : ^data;

endmodule


module parity_checker #(parameter WIDTH = 8, parameter ODD = 0)
(
    input  [WIDTH-1:0] data_in,
    input              parity_in,
    output             error
);

wire e_parity;
wire exp_parity;

assign e_parity   = ^data_in;
assign exp_parity = (ODD) ? ~e_parity : e_parity;

assign error = (exp_parity != parity_in);

endmodule
