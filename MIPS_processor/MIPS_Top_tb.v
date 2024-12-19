`timescale 1ns / 1ps

module MIPS_TOP_tb;

    // Declare inputs as registers
    reg clk;
    reg reset;

    // Declare outputs as wires
    wire [31:0] pc_out;
    wire [31:0] alu_out;
    wire [31:0] reg_write_data;

    // Instantiate the MIPS_TOP module
    MIPS_TOP uut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .alu_out(alu_out),
        .reg_write_data(reg_write_data)
    );

    // Clock Generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 ns (100 MHz)
    end

    // Initial block to apply stimulus
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;

        // Apply reset and release after some time
        #10 reset = 0;  // Release reset after 10ns

        // Check the outputs after some cycles
        #100;

        // Add more stimulus or checks here if needed
        
        // Finish the simulation
        $finish;
    end

    // Monitor signals for debugging
    initial begin
        $monitor("At time %t, PC = %h, ALU Output = %h, Reg Write Data = %h", $time, pc_out, alu_out, reg_write_data);
    end

    // Load instructions into memory from file
    initial begin
        $readmemh("instructions.hex", uut.imem.memory);
    end

endmodule
