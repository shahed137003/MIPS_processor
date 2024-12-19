module mux_2to1 (
    input [31:0] in0,      // Input 0
    input [31:0] in1,      // Input 1
    input select,          // Select signal
    output [31:0] out      // Output
);
    assign out = (select) ? in1 : in0; // Select between in0 and in1
endmodule

