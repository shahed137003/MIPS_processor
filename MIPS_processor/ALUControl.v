module alu_control (
    input [1:0] ALUOp,          // ALU operation from Control Unit
    input [5:0] funct,          // Function field from R-type instruction
    output reg [3:0] ALUControl // ALU control signals
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 4'b0010; // Load/Store (ADD)
            2'b01: ALUControl = 4'b0110; // Branch (SUBTRACT)
            2'b10: begin
                case (funct) // R-type instructions
                    6'b100000: ALUControl = 4'b0010; // ADD
                    6'b100010: ALUControl = 4'b0110; // SUBTRACT
                    6'b100100: ALUControl = 4'b0000; // AND
                    6'b100101: ALUControl = 4'b0001; // OR
                    6'b101010: ALUControl = 4'b0111; // SLT
                    6'b100111: ALUControl = 4'b1100; // NOR
                    default:   ALUControl = 4'b0000; // Default (AND)
                endcase
            end
            default: ALUControl = 4'b0000; // Default to AND for invalid ALUOp
        endcase
    end

endmodule
