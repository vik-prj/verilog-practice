/* Design a parameterized barrel shifter supporting logical shift left, logical shift right, arithmetic
shift right, and rotate left/right. The shift amount is variable. All operations must be
combinational with zero propagation delay (no clock). */

module barrel_shifter #(parameter WIDTH = 1) (data_in, shift_by, op, data_out);
  input [WIDTH-1:0] data_in;
  input [$clog2(WIDTH)-1:0] shift_by;
  input [2:0] op;
  output [WIDTH-1:0] data_out;

  localparam LSL = 3'b000;
  localparam LSR = 3'b001;
  localparam ASR = 3'b010;
  localparam ROL = 3'b011;
  localparam ROR = 3'b100;

  always @(*) begin
    case(op)
      LSL : data_out = data_in << shift_by;
      LSR : data_out = data_in >> shift_by;
      ASR : data_out = $signed(data_in) >>> shift_by;
      ROL : data_out = data_in << shift_by | data_in >> (WIDTH - shift_by);
      ROR : data_out = data_in >> shift_by | data_in << (WIDTH - shift_by);
      default : data_out = data_in;
    endcase
  end
endmodule
    
