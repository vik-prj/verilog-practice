/*Design a parameterized synchronous FIFO (single clock domain). Include: wr_en, rd_en,
full, empty, count outputs. Both read and write are registered (synchronous). Depth and
data width are parameters. Handle simultaneous read/write correctly.*/

module fifo #(parameter WIDTH = 8,
              parameter DEPTH = 16)
(
    input                    clk,
    input                    rst,
    input                    wr_en,
    input                    rd_en,
    input  [WIDTH-1:0]       data_in,

    output reg [WIDTH-1:0]   data_out,
    output                   full,
    output                   empty,
    output reg [$clog2(DEPTH):0] count
);

    // FIFO Memory
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // Read & Write Pointers
    reg [$clog2(DEPTH)-1:0] wr_ptr;
    reg [$clog2(DEPTH)-1:0] rd_ptr;

    integer i;

    //-------------------------------------------------------
    // Synchronous FIFO
    //-------------------------------------------------------
    always @(posedge clk) begin
        if (rst) begin
            wr_ptr   <= 0;
            rd_ptr   <= 0;
            count    <= 0;
            data_out <= 0;

            for (i = 0; i < DEPTH; i = i + 1)
                mem[i] <= 0;
        end
        else begin

            //---------------------------
            // Write
            //---------------------------
            if (wr_en && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1'b1;
            end

            //---------------------------
            // Read
            //---------------------------
            if (rd_en && !empty) begin
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1'b1;
            end

            //---------------------------
            // Count Update
            //---------------------------
            case ({wr_en && !full, rd_en && !empty})

                2'b10: count <= count + 1'b1; // Write only

                2'b01: count <= count - 1'b1; // Read only

                2'b11: count <= count;        // Simultaneous Read & Write

                default: count <= count;

            endcase

        end
    end

    //-------------------------------------------------------
    // Status Flags
    //-------------------------------------------------------
    assign empty = (count == 0);
    assign full  = (count == DEPTH);

endmodule
