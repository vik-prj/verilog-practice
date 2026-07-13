/* Design a parameterized clock divider that produces an output clock clk_out at 1/N of the
input clock frequency. For even N, the output should have 50% duty cycle. The module
should be synthesizable */

module clock_divider #(parameter DIV = 8) (clk, rst, clock_out);
  
  input clk, rst;
  output reg clock_out;
  
  reg [$clog2(DIV)-1:0] count;
  
  always @(posedge clk) begin
    if(rst) begin
      clock_out <= 1'b0;
      count <= 0;
    end
    else begin
      if(count == (DIV/2) - 1) begin
        count <= 0;
        clock_out <= ~clock_out;
      end
      else
        count <= count + 1;
    end
  end
endmodule
