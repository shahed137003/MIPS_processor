# MIPS Processor Simulation

![MIPS Processor](https://img.icons8.com/ios-filled/50/000000/processor.png)

## Overview

This project implements a simple 32-bit MIPS processor using Verilog. It includes all the core components of a basic MIPS pipeline, including the program counter, ALU, register file, memory, control unit, and necessary multiplexers. The processor supports fundamental MIPS instructions, such as arithmetic and logical operations, data load/store, conditional branches, and jumps.

The project also includes a testbench that simulates the processor’s behavior, providing a simple way to verify the functionality of the processor components and their interactions.

## Key Features

- **MIPS Processor Core**: Simulates the execution of MIPS instructions using components like ALU, registers, and control logic.
- **Instruction Support**:  Implements key MIPS instruction types, including:
  - R-type (arithmetic and logical operations)
  - I-type (load, store, and immediate operations)
  - J-type (jump operations)
  - Branch instructions (conditional branches like `beq`)
- **Data Memory and Instruction Memory**: ![Memory](https://img.icons8.com/ios-filled/50/000000/database.png) Includes separate memory modules for instructions and data, both of which are simulated and allow read/write operations.
- **Control Unit**: ![Control](https://img.icons8.com/ios-filled/50/000000/settings.png) Decodes instruction opcodes and generates control signals to control the execution of instructions.
- **ALU**: ![ALU](https://img.icons8.com/ios-filled/50/000000/plus-2-math.png) Supports various arithmetic and logical operations such as addition, subtraction, AND, OR, etc.

## Components

1. **Program Counter (PC)**: ![Program Counter](https://img.icons8.com/ios-filled/50/000000/clock.png) Keeps track of the address of the next instruction to fetch and updates based on the current instruction type (sequential, branch, or jump).
2. **Sign Extend**: ![Sign Extend](https://img.icons8.com/ios-filled/50/000000/arrow.png) Extends the 16-bit immediate values in I-type instructions to 32 bits.
3. **Register File**: ![Register](https://img.icons8.com/ios-filled/50/000000/stack-of-photos.png) Contains 32 registers for storing data, with read and write capabilities controlled by the `reg_write` signal.
4. **ALU Control**: Generates the necessary control signals for the ALU to perform the correct operation based on the opcode and function code.
5. **Control Unit**: ![Control Unit](https://img.icons8.com/ios-filled/50/000000/network.png) Determines the operations of the processor based on the opcode and generates signals for ALU, memory, and branching.
6. **Instruction Memory**: ![Instruction Memory](https://img.icons8.com/ios-filled/50/000000/laptop.png) Holds the instructions for execution, initialized from a `.hex` file.
7. **Data Memory**: Simulates data storage, allowing the processor to load and store data during execution.
8. **Multiplexer**: ![Multiplexer](https://img.icons8.com/ios-filled/50/000000/switch.png) Selects between different inputs based on the control signals, used for various data path decisions.

## Testbench

The testbench (`MIPS_TOP_tb`) drives the simulation of the MIPS processor by providing a clock signal, applying reset, loading instructions into the instruction memory, and monitoring key outputs like the program counter, ALU results, and register data.

- **Clock Generation**: ⏰ The clock is generated with a period of 10 ns, simulating a 100 MHz clock.
- **Reset**: 🔄 The processor is reset initially to ensure it starts in a known state.
- **Instruction Initialization**: 📑 Instructions are loaded from an external `instructions.hex` file, providing a simple way to specify the instruction sequence to be executed.
- **Simulation Monitoring**: 📊 Key outputs such as the program counter, ALU output, and register write data are monitored and displayed in the simulation log for debugging and verification purposes.

## Requirements

- **Verilog Simulator**: 🖥️ A Verilog simulator (e.g., ModelSim, Vivado, or Questa) is required to compile and run the Verilog code.
- **Hex File for Instructions**: 📝 A hex file containing the MIPS machine code instructions for testing the processor.

## How to Run the Simulation

1. **Set up your Verilog environment**: Ensure you have a Verilog simulator like ModelSim or Vivado installed.
2. **Prepare the instruction memory file**: Create a `.hex` file containing the MIPS instructions you want to execute. Each line in the file represents a 32-bit instruction in hexadecimal format.
3. **Run the simulation**: 🎬 Compile and simulate the design. The testbench will load the instructions from the `.hex` file, apply a reset, and then run the processor, showing the outputs in the simulation log.

## Example Instructions File (`instructions.hex`)


## Simulation Outputs

The simulation will display outputs for key signals, including:

- **PC (Program Counter)**: The address of the current instruction being executed.
- **ALU Output**: The result of the ALU operation.
- **Register File Data**: The data written to or read from the registers during execution.

## Future Work

- **Support for additional MIPS instructions**: The processor can be extended to support more complex instructions, such as `slt`, `nor`, and others.
- **Pipeline implementation**: To enhance performance, the processor could be extended to implement a pipelined architecture, where different stages of instruction execution are handled simultaneously.
- **Branch Prediction**: Implementing branch prediction algorithms to improve the handling of branch instructions.

## License

This project is licensed under the MIT License.

## Acknowledgments

This project was created as part of a learning exercise in MIPS processor design. It simulates the basic operations of a simple MIPS processor and can be used as a foundation for more advanced processor designs.

