/* Design a 4-to-1 multiplexer with a 2-bit select input. When sel = 2’b00output y = in0, sel = 2’b01 gives y = in1, 
and so on. Write a parameterized version supporting configurable data width. */

module mux4x1 #(parameter DATA_WIDTH = 8) (I0,I1,I2,I3,Y,Sel);
  input [DATA_WIDTH-1:0] I0;
  input [DATA_WIDTH-1:0] I1;
  input [DATA_WIDTH-1:0] I2;
  input [DATA_WIDTH-1:0] I3;
  
  input [1:0] Sel;
  output reg [DATA_WIDTH-1:0] Y;
  
  always @(*) begin
    case(Sel)
      2'd0 : Y = I0;
      2'd1 : Y = I1;
      2'd2 : Y = I2;
      2'd3 : Y = I3;
      default : Y = {DATA_WIDTH{1'b0}};
    endcase
  end
endmodule
