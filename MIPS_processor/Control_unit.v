
module control_unit (
    input [5:0] opcode,      // Opcode field from the instruction
    output reg RegDst,       // Register destination select
    output reg ALUSrc,       // ALU source select
    output reg MemToReg,     // Memory to register select
    output reg RegWrite,     // Register write enable
    output reg MemRead,      // Memory read enable
    output reg MemWrite,     // Memory write enable
    output reg Branch,       // Branch signal
    output reg Jump,         // Jump signal
    output reg [1:0] ALUOp   // ALU operation code
);

    always @(*) begin
        // Default values for control signals
        RegDst = 0; ALUSrc = 0; MemToReg = 0; RegWrite = 0;
        MemRead = 0; MemWrite = 0; Branch = 0; Jump = 0; ALUOp = 2'b00;

        case (opcode)
            6'b000000: begin // R-type
                RegDst = 1;
                RegWrite = 1;
                ALUOp = 2'b10;
            end
            6'b100011: begin // lw
                ALUSrc = 1;
                MemToReg = 1;
                RegWrite = 1;
                MemRead = 1;
                ALUOp = 2'b00;
            end
            6'b101011: begin // sw
                ALUSrc = 1;
                MemWrite = 1;
                ALUOp = 2'b00;
            end
            6'b000100: begin // beq
                Branch = 1;
                ALUOp = 2'b01;
            end
            6'b001000: begin // addi
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00;
            end
            6'b000010: begin // jump
                Jump = 1;
            end
            default: begin // Default case
                RegDst = 0; ALUSrc = 0; MemToReg = 0; RegWrite = 0;
                MemRead = 0; MemWrite = 0; Branch = 0; Jump = 0; ALUOp = 2'b00;
            end
        endcase
    end

endmodule
