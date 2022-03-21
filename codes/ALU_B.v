module Mux_ALU_B(
        input [31:0] imm,
        input [31:0] rD2,
        input ALU_B_sel,
        output [31:0] B
    );
    assign B = ALU_B_sel ? rD2 : imm;
endmodule
