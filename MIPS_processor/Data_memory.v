module data_memory (
    input clk,                 // Clock signal
    input mem_write,           // Write enable signal
    input mem_read,            // Read enable signal
    input [31:0] address,      // Memory address
    input [31:0] write_data,   // Data to be written
    output reg [31:0] read_data // Data read from memory
);

    // Memory array: 1024 words (32-bit each)
    reg [31:0] memory [0:1023];

    // Load instructions into memory at initialization
    initial begin
        $readmemh("data_memory.hex", memory); // Load instructions from hex file
    end

    // Memory operation: read/write based on control signals
    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[11:2]] <= write_data;  // Store data into memory
        end
    end

    always @(*) begin
        if (mem_read) begin
            read_data = memory[address[11:2]];   // Read data from memory
        end
    end

endmodule

