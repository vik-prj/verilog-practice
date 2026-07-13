/* Design a parameterized D flip-flop with synchronous active-high reset. When rst = 1 on the
rising clock edge, the output resets to 0. Include a synchronous load enable (en). */

module d_ff #(parameter DATA_WIDTH = 8) (clk, rst, d_in, q, en);
  input clk, rst, en;
  input [DATA_WIDTH-1:0] d_in;
  output reg [DATA_WIDTH-1:0] q;
  
  always @(posedge clk) begin
    if(rst)
      q <= {DATA_WIDTH{1'b0}};
    else if (en)
      q <= d_in;
    else
      q <= q;
  end
endmodule
