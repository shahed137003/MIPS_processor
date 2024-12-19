module sign_extend (
    input [15:0] in,       // 16-bit input value
    output [31:0] out      // 32-bit output value after sign extension
);

    assign out = {{16{in[15]}}, in}; // Extend the MSB of `in` (sign bit) to the upper 16 bits

endmodule

