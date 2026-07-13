/* Design a parameterized synchronous binary up counter with synchronous reset, load enable,
and a terminal count output (tc) that pulses for one clock cycle when the counter reaches its
maximum value. */

module up_counter #(parameter WIDTH = 4) (clk, rst, load, en, d_in, tc, count);
  input clk, rst, en, load;
  input [WIDTH-1:0] d_in;
  output reg tc;
  output reg [WIDTH-1:0] count;
  
  always @(posedge clk) begin
    tc <= 1'b0;
    if(rst)
      count <= {WIDTH{1'b0}};
    else if(load)
      count <= d_in;
    else if (en) begin
      if(count == {WIDTH{1'b1}}) tc <= 1'b1;
        count <= count + 1'b1;
    end
  end
endmodule
