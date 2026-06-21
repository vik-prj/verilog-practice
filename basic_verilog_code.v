module half_adder(a,b,sum,carry);
  input a,b;
  output sum,carry;
  
  assign sum = a^b;
  assign carry = a&b;
endmodule

module mux_2x1 (i0,i1,sel,y);
  input i0, i1, sel;
  output reg y;
  
  always @(*) begin
    case(sel) 
      1'b0 : y = i0;
      1'b1 : y = i1;
      default: y = 1'b0;
    endcase
  end
  
  // assign y = sel? i1 : i0;
endmodule

module d_ff (D, clk, rst, Q);
  input clk, rst, D;
  output reg Q;
  
  always @(posedge clk) begin
    if(rst)
      Q <= 1'b0;
    else
      Q <= D;
  end
endmodule

module up_counter_4bit (clk, rst, count);
  input clk, rst;
  output reg [3:0] count;
  
  always @(posedge clk) begin
    if(rst) 
      count <= 4'b0;
    else
      count <= count + 4'b1;
  end
endmodule

module decode_3x8 (I,Y);
  input [2:0] I;
  output reg [7:0] Y;
  
  always @(*) begin
    case(I)
      3'b000 : Y = 8'b00000001;
      3'b001 : Y = 8'b00000010;
      3'b010 : Y = 8'b00000100;
      3'b011 : Y = 8'b00001000;
      3'b100 : Y = 8'b00010000;
      3'b101 : Y = 8'000100000;
      3'b110 : Y = 8'b01000000;
      3'b111 : Y = 8'b10000000;
      default : Y = 8'b0;
    endcase
    
    // Y = 8'b00000001 << I;
  end
endmodule
