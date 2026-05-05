//Parallel-in, Serial-out Shift Register
module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  input din_en,
  output logic dout
);

reg [DATA_WIDTH-1:0] temp;

always @(posedge clk) begin
  if(!resetn) begin
    temp <= 0;
  end
  else if(din_en) begin
    temp <= din;
  end
  else begin
    temp <= temp >> 1;
  end
end 

assign dout = temp[0];

endmodule
