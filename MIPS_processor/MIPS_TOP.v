module MIPS_TOP(input clk, reset,
                output [31:0] pc_out,          // Program Counter output
                output [31:0] alu_result,      // ALU result output
                output [31:0] write_data);     // Write data to register file

    // Wire Declarations
    wire [31:0] instruction_in_add, instruction_out_add, register_data1, register_data2;
    wire [31:0] sign_extended_imm, ALUOP2, data_address, read_data, instruction, ALUresult_branch, PC_adderRes;
    wire Zero_flag, RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump;
    wire [1:0] ALUOp; // ALUOp is typically a 2-bit signal for MIPS
    wire [4:0] Write_reg;  // Register to write back
    wire [3:0] ALUControl;

    // Program Counter
    program_counter program_counter (
        .pc_in(instruction_in_add),
        .clk(clk),
        .reset(reset),
        .pc_out(instruction_out_add)
    );

    // PC Incrementer
    pc_adder pc_adder (
        .pc_in(instruction_out_add),
        .increment(32'd4),
        .pc_out(PC_adderRes)
    );

    // Instruction Memory
    instruction_memory instruction_memory (
        .address(instruction_out_add),
        .instruction(instruction)
    );

    // Register File Mux for Write Register Selection
    mux_2to1 mux_2to1_reg (
        .in0(instruction[20:16]), // RT field for R-type instructions
        .in1(instruction[15:11]), // RD field for R-type instructions
        .select(RegDst),           // Determines whether to use RT or RD
        .out(Write_reg)
    );

    // Register File
    Register_file Register_file (
        .clk(clk),
        .reset(reset),
        .read_reg1(instruction[25:21]), // RS
        .read_reg2(instruction[20:16]), // RT
        .write_reg(Write_reg),
        .write_data(write_data),
        .reg_write(RegWrite),
        .read_data1(register_data1),
        .read_data2(register_data2)
    );

    // Sign Extend
    sign_extend sign_extend (
        .in(instruction[15:0]), // Immediate field
        .out(sign_extended_imm)
    );

    // ALU Input Mux
    mux_2to1 mux_2to1_alu (
        .in0(register_data2),
        .in1(sign_extended_imm),
        .select(ALUSrc), // Determines if the second operand is register data or immediate value
        .out(ALUOP2)
    );

    // Main ALU
    ALU ALU1 (
        .operand1(register_data1),
        .operand2(ALUOP2),
        .alu_control(ALUControl),
        .result(alu_result),   // Output the ALU result
        .zero(Zero_flag)
    );

    // Data Memory
    data_memory data_memory (
        .clk(clk),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .address(data_address),
        .write_data(register_data2),
        .read_data(read_data)
    );

    // Write-back Mux
    mux_2to1 mux_2to1_mem (
        .in0(data_address),
        .in1(read_data),
        .select(MemToReg),
        .out(write_data)
    );

    // Control Unit
    control_unit control_unit (
        .opcode(instruction[31:26]), // Opcode field from the instruction
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp) // ALUOp typically 2-bit
    );

    // ALU Control
    alu_control alu_control (
        .ALUOp(ALUOp),
        .funct(instruction[5:0]), // Function field for R-type instructions
        .ALUControl(ALUControl)
    );

    // Branch Address Calculation
    ALU ALU_branch (
        .operand1(PC_adderRes),
        .operand2(sign_extended_imm << 2), // Shift the immediate for word alignment
        .alu_control(4'b0010), // ALU control for addition
        .result(ALUresult_branch),
        .zero(Zero_flag)  
    );

    // PC Mux for Branch
    mux_2to1 mux_2to1_branch (
        .in0(PC_adderRes),    // No branch
        .in1(ALUresult_branch), // Branch target
        .select(Branch & Zero_flag), // Branch if Zero flag is set
        .out(instruction_in_add)
    );

    // Output assignments to match testbench
    assign pc_out = instruction_out_add;  // Program counter output
    assign alu_result = alu_result;       // ALU result output
    assign write_data = write_data;       // Write data to register file

endmodule

