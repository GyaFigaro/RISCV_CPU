module npc(
        input [31:0] pc,
        input [31:0] imm,
        //input npc_sel,
        output reg [31:0] new_pc
    );
    always @(*)
    begin
        new_pc = pc + imm;
    end
endmodule
