
  
  //

// MIPS Program Counter Module
module ProgramCounter(
    input wire clk,            // Clock signal
    input wire reset,          // Reset signal
    input wire [31:0] pc_in,   // Input for the next PC value
    output reg [31:0] pc_out   // Output for the current PC value
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 32'b0;   // Reset the PC to 0
        end else begin
            pc_out <= pc_in;   // Update PC to the next value
        end
    end

endmodule
