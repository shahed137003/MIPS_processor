module pc_adder (
    input [31:0] pc_in,         // Current PC value
    input [31:0] increment,     // Value to add (e.g., 4 for sequential execution)
    output [31:0] pc_out        // Next PC value
);
    assign pc_out = pc_in + increment; // Perform the addition
endmodule
