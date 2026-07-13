/* Design a Moore-style FSM that detects the serial bit sequence 101. The output detected is
asserted for one cycle after the complete sequence is observed. Support overlapping detection. */

module fsm (clk, rst, seq_in, out);
  
  input seq_in, clk, rst;
  output out;
  
  parameter IDLE = 2'b00, S1 = 2'b01, S10 = 2'b10, S101 = 2'b11;
  
  reg [1:0] state, next_state;
  
  always @(posedge clk) begin
    if(rst)
      state <= IDLE;
    else
      state <= next_state;
  end
  
  always @(*) begin
    case(state)
      2'b00 : if(seq_in)
        next_state = S1;
        else
          next_state = IDLE;
      
      2'b01 : if(seq_in)
        next_state = S1;
        else
          next_state = S10;
      
      2'b10 : if(seq_in)
        next_state = S101;
        else
          next_state = IDLE;
      
      2'b11 : if(seq_in)
        next_state = S1;
        else
          next_state = S10;
      
      default : next_state = IDLE;
    endcase
  end
  
  assign out = (state == S101)? 1 : 0;
  
endmodule
        
        
