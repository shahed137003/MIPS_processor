module instruction_memory (
    input [31:0] address,      // Memory address
    output reg [31:0] instruction // Instruction read from memory
);

    // Memory array: 1024 words (32-bit each)
    reg [31:0] memory [0:1023];

    // Load instructions into memory
    initial begin
        $readmemh("instructions.hex", memory); // Load instructions from a file
    end

    // Read operation (combinational)
    always @(*) begin
        instruction = memory[address[11:2]]; // Word-aligned address
    end

endmodule

