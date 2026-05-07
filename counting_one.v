module model #(parameter DATA_WIDTH = 16) (
  input [DATA_WIDTH-1:0] din,
  output [4:0] dout
);

integer i;
reg [4:0] one;

always @(*) begin
  one = 0;
  for(i = 0; i < DATA_WIDTH; i = i + 1) begin
    if(din[i] == 1'b1) begin
      one = one + 1;
    end
  end
end

assign dout = one;

endmodule
