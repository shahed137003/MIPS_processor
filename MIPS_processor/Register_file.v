module Register_file (
    input clk,
    input reset,
    input [4:0] read_reg1,   // 5-bit register address for read port 1
    input [4:0] read_reg2,   // 5-bit register address for read port 2
    input [4:0] write_reg,   // 5-bit register address for write port
    input [31:0] write_data, // Data to write to the register
    input reg_write,         // Write enable signal
    output [31:0] read_data1, // Data read from read port 1
    output [31:0] read_data2  // Data read from read port 2
);

    // 32 registers of 32 bits each
    reg [31:0] registers [0:31];
    integer i;
    // Read logic (asynchronous)
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // Write logic (synchronous)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to 0
            
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (reg_write && write_reg != 0) begin
            // Write data to the specified register (excluding $zero)
            registers[write_reg] <= write_data;
        end
    end
endmodule

