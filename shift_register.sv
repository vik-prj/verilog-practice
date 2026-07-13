/* Design a parameterized universal shift register that supports four modes via a 2-bit control:
00=Hold, 01=Shift-Right, 10=Shift-Left, 11=Parallel Load. */

module shift_register #(parameter WIDTH = 8) (clk, rst, d_in, ctrl, out);
  input clk, rst;
  input [WIDTH-1:0] d_in;
  input [1:0] ctrl;
  output [WIDTH-1:0] out;
  
  reg [WIDTH-1:0] temp;
  
  always @(posedge clk) begin
    if(rst)
      temp <= {WIDTH{1'b0}};
    else begin
      case(ctrl)
        2'b00 : temp <= temp; //HOLD
        2'b01 : temp <= temp >> 1; //RIGHT SHIFT
        2'b10 : temp <= temp << 1; //LEFT SHIFT
        2'b11 : temp <= d_in; //LOAD
        default : temp <= {WIDTH{1'b0}};
      endcase
    end
  end
  
  assign out = temp;
endmodule
        
        
      
