module Mux_pc(
        input [31:0] pc_add_i,
        input [31:0] npc_i,
        input [31:0] ALU_i,
        input branch,//ALU_input
        input [1:0] pc_sel,
        output reg [31:0] pc
    );
    always@ (*)
    begin
        case(pc_sel)     
            2'b00:       //pc+4
                pc = pc_add_i;
            2'b01:       //pc+imm 
                if(branch == 1)
                begin
                    pc = npc_i;
                end
                else begin
                pc = pc_add_i;
                end
            2'b10:       //pc + imm
                pc = npc_i;
            2'b11:       //rs1 + imm
                pc = ALU_i; 
    
        endcase
    end
endmodule
