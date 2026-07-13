/* Design a 3-to-8 binary decoder with an active-high enable input. When en = 1, exactly one
of the 8 output lines is asserted high based on the 3-bit input in. When en = 0, all outputs
are low.*/

//Method 1
module decoder3x8 (in,out,en);
  input [2:0] in;
  input en;
  output reg [7:0] out;
  
  always @(*) begin
    if(en) begin
      case(in)
        3'd0 : out = 8'b00000001;
        3'd1 : out = 8'b00000010;
        3'd2 : out = 8'b00000100;
        3'd3 : out = 8'b00001000;
        3'd4 : out = 8'b00010000;
        3'd5 : out = 8'b00100000;
        3'd6 : out = 8'b01000000;
        3'd7 : out = 8'b10000000;
        default : out = 8'b0;
      endcase
    end
    else
      out = 8'b0;
  end
endmodule

//Method 2
module decoder3x8 (
    input  [2:0] in,
    input        en,
    output [7:0] out
);

assign out = en ? (8'b00000001 << in) : 8'b00000000;

endmodule

//Method 3
module decoder3to8 (
    input  [2:0] in,
    input        en,
    output reg [7:0] out
);

always @(*) begin
    if (!en) begin
        out = 8'h00;          // All outputs low when disabled
    end
    else begin
        out = 8'h00;          // Clear all outputs
        out[in] = 1'b1;       // Set the selected output bit
    end
end

endmodule
