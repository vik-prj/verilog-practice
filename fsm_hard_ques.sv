/*
Write RTL for a sequence detector that detects 1010 in an overlapping manner, but with a twist: the detector must 
also assert a separate error output for exactly one cycle if it ever receives 3 consecutive 0s (a "line idle" fault condition), 
and detection logic must correctly resume afterward. Think about whether this needs one FSM or two, and why.
*/

module fsm (seq_in, clk, rst, out, error);
  input seq_in, clk, rst;
  output out, error;

  parameter idle=3'd0, s1=3'd1, s10=3'd2, s101=3'd3, s1010=3'd4;
  parameter IDLE=2'd0, S0=2'd1, S00=2'd2, S000=2'd3;

  reg [2:0] state, next_state;
  reg [1:0] STATE, NEXT_STATE;

  always @(posedge clk) begin
    if (rst) begin state <= idle; STATE <= IDLE; end
    else     begin state <= next_state; STATE <= NEXT_STATE; end
  end

  always @(*) begin
    case(state)
      idle  : next_state = seq_in ? s1    : idle;
      s1    : next_state = seq_in ? s1    : s10;
      s10   : next_state = seq_in ? s101  : idle;
      s101  : next_state = seq_in ? s1010 : s10;
      s1010 : next_state = seq_in ? s101  : s10;   // overlap: '10' tail reused
      default: next_state = idle;
    endcase
  end

  always @(*) begin
    case(STATE)
      IDLE: NEXT_STATE = seq_in ? IDLE : S0;
      S0  : NEXT_STATE = seq_in ? IDLE : S00;
      S00 : NEXT_STATE = seq_in ? IDLE : S000;
      S000: NEXT_STATE = seq_in ? IDLE : S0;
      default: NEXT_STATE = IDLE;
    endcase
  end

  assign out   = (state == s1010);
  assign error = (STATE == S000);
endmodule
