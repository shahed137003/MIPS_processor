module ALU (
    input [31:0] operand1,   // First operand
    input [31:0] operand2,   // Second operand
    input [3:0] alu_control, // Control signal to select ALU operation
    output reg [31:0] result, // Result of the operation
    output zero              // Zero flag
);

    // Zero flag logic
    assign zero = (result == 32'b0);

    // ALU operation
    always @(*) begin
        case (alu_control)
            4'b0000: result = operand1 & operand2;        // AND
            4'b0001: result = operand1 | operand2;        // OR
            4'b0010: result = operand1 + operand2;        // ADD
            4'b0110: result = operand1 - operand2;        // SUB
            4'b0111: result = (operand1 < operand2) ? 32'b1 : 32'b0; // SLT
            4'b1100: result = ~(operand1 | operand2);     // NOR
            4'b0011: result = operand1 ^ operand2;        // XOR
            4'b1000: result = operand2 << operand1[4:0];  // Shift left logical
            4'b1001: result = operand2 >> operand1[4:0];  // Shift right logical
            default: result = 32'b0;                      // Default case
        endcase
    end

endmodule
