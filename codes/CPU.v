module cpu(
        input clk,
        input reset,
        input [31:0] IF_inst,
        input [31:0] MEM_WriteData,
        output WB_RegWrite,
        output [31:0] IF_pc,
	output [31:0] WB_pc,
        output [31:0] MEM_C,
        output [31:0] MEM_rD2,
        output MEM_wr_i,
        output WB_bubble,
        output [31:0] WB_WriteData,
output [31:0] WB_inst
    );
   
     
    
    wire case_A1;
    wire case_B1;
    wire case_C1;
	wire case_A2;
    wire case_B2;
    wire case_C2;
   
    wire [1:0] ID_pc_sel;
    wire [3:0] ID_ALU_op;
    wire ID_ALU_B_sel;
    wire [2:0] Imm_sel;
    wire ID_wr_i;
    wire jump;
    wire stop;//lw
    wire EX_branch;
    wire IF_bubble;
    wire [31:0] IF_pc4;  
    wire [31:0] ID_pc;
    wire [31:0] ID_pc4;
    wire [31:0] ID_inst;
    wire [31:0] ID_imm;
    wire [31:0] ID_A;
    wire [31:0] ID_B;
    wire [31:0] ID_rD2;
    wire [31:0] ID_pc_imm;
	wire ID_bubble;
	wire ID_bubble1;
    wire ID_bubble2;
	wire [1:0] ID_wD_sel;
	wire ID_RegWrite;
	wire ID_re1;
    	wire ID_re2;
    	
   wire [31:0] EX_pc;
    wire [31:0] EX_pc4;
    wire [31:0] EX_pc_imm;
    wire [31:0] EX_npc;
    wire [31:0] EX_A;
    wire [31:0] EX_B;
    wire [31:0] EX_C;
    wire [1:0] EX_pc_sel;
    wire [3:0] EX_ALU_op;
    wire  EX_wr_i;
    wire [31:0] EX_rD2;
    wire [31:0] EX_inst;
    wire EX_bubble;
wire [1:0] EX_wD_sel;
wire EX_RegWrite;
wire [31:0] EX_imm;
	wire EX_re1;
    	wire EX_re2;
	wire EX_ALU__B_sel;
    wire [31:0] MEM_WriteData2;
	wire [31:0] MEM_pc;
    wire [31:0] MEM_inst;
    wire MEM_bubble;
wire [1:0] MEM_wD_sel;
wire [31:0] MEM_pc4;
wire MEM_RegWrite;
wire [31:0] MEM_imm;
wire MEM_re1;
    	wire MEM_re2;
wire [1:0] WB_wD_sel;
wire [31:0] WB_pc4;
    //wire [31:0] WB_pc;
wire [31:0] WB_C;
wire WB_re1;
    	wire WB_re2;
    
	wire cnt;
	assign cnt =(jump==1)?0:0;
    //IF
    pc pc_1(
    .clk(clk),
    .reset(reset),
    .new_pc(EX_npc),
	.stop(stop),
    .pc(IF_pc)
    );
    
    
    
    pc_add pc_add_1(
    .pc(IF_pc),
    .pc4(IF_pc4)
    );
    
     IF_ID U_IF_ID(
        .clk(clk),
        .reset(reset),
        .jump(jump),
        .stop(stop),
        .pc_i(IF_pc),
        .pc4_i(IF_pc4),
        .inst_i(IF_inst), 
        .pc_o(ID_pc),
        .pc4_o(ID_pc4),
        .inst_o(ID_inst),
        .bubble(ID_bubble1)
    );
    
   //ID
    RF RF_1(
    .clk(clk),
    .RegWrite(WB_RegWrite),
	.inst2(ID_inst),
    .inst5(WB_inst),
    .WriteData(WB_WriteData),
    .rD1(ID_A),
    .rD2(ID_rD2)
    );
    
     IMM IMM_1(
    .inst(ID_inst),
    .Imm_sel(Imm_sel),
    .imm(ID_imm)
    );
    
    npc npc_01(
    .pc(ID_pc),
    .imm(ID_imm),
    .new_pc(ID_pc_imm)
    );
    
    
    Mux_ALU_B Mux_ALU_B_1(
    .imm(EX_imm),
    .rD2(EX_rD2),
    .ALU_B_sel(EX_ALU_B_sel),
    .B(EX_B)
    );
    
    ID_EX U_ID_EX(
        .clk(clk),
        .reset(reset),
        .jump(jump),
        .stop(stop),
        .case_A1(case_A1),
        .case_B1(case_B1),
        .case_C1(case_C1),
        .case_A2(case_A2),
        .case_B2(case_B2),
        .case_C2(case_C2),
        .EX_to_ID(EX_C),
        .MEM_to_ID(MEM_WriteData2),
        .WB_to_ID(WB_WriteData),
        .wr_i_i(ID_wr_i),
        .pc_sel_i(ID_pc_sel),
        .ALU_op_i(ID_ALU_op),
        .A_i(ID_A),
        //.B_i(ID_B),
        .rD2_i(ID_rD2),
        .inst_i(ID_inst),
        .pc_imm_i(ID_pc_imm),
        .bubble_i(ID_bubble),
	.wD_sel_i(ID_wD_sel),
	.pc4_i(ID_pc4),
	.pc_i(ID_pc),
	.RegWrite_i(ID_RegWrite),
	.imm_i(ID_imm),
	.re1_i(ID_re1),
	.re2_i(ID_re2),
	.ALU_B_sel_i(ID_ALU_B_sel),
        .wr_i_o(EX_wr_i),
        .pc_sel_o(EX_pc_sel),
        .ALU_op_o(EX_ALU_op),
        .A_o(EX_A),
        //.B_o(EX_B),
        .rD2_o(EX_rD2),
        .inst_o(EX_inst),
        .pc_imm_o(EX_pc_imm),
        .bubble_o(EX_bubble),
	.wD_sel_o(EX_wD_sel),
	.pc4_o(EX_pc4),
	.pc_o(EX_pc),
	.RegWrite_o(EX_RegWrite),
	.imm_o(EX_imm),
	.re1_o(EX_re1),
	.re2_o(EX_re2),
	.ALU_B_sel_o(EX_ALU_B_sel)
    );
    
    //EX
    ALU ALU_1(
    .A(EX_A),
    .B(EX_B),
    .ALU_op(EX_ALU_op),
    .flag(EX_branch),
    .C(EX_C)
    );
    
     Mux_pc Mux_pc_1(
    .pc_add_i(IF_pc4),
    .npc_i(EX_pc_imm),
    .ALU_i(EX_C),
    .branch(EX_branch),
    .pc_sel(EX_pc_sel),
    .pc(EX_npc)
    );
    
    EX_MEM U_EX_MEM(
    .clk(clk),
    .reset(reset),
    .C_i(EX_C),
    .rD2_i(EX_rD2),
    .wr_i_i(EX_wr_i),
    .inst_i(EX_inst),
    .bubble_i(EX_bubble),
	.wD_sel_i(EX_wD_sel),
	.pc_i(EX_pc),
	.pc4_i(EX_pc4),
	.RegWrite_i(EX_RegWrite),
	.imm_i(EX_imm),
	.re1_i(EX_re1),
	.re2_i(EX_re2),
    .C_o(MEM_C),
    .rD2_o(MEM_rD2),
    .wr_i_o(MEM_wr_i),
    .inst_o(MEM_inst),
    .bubble_o(MEM_bubble),
	.wD_sel_o(MEM_wD_sel),
	.pc_o(MEM_pc),
	.pc4_o(MEM_pc4),
	.RegWrite_o(MEM_RegWrite),
	.imm_o(MEM_imm),
	.re1_o(MEM_re1),
	.re2_o(MEM_re2)
    
    
    );
    
    
    
       //MEM
    MEM_WB U_MEM_WB(
    .clk(clk),
    .reset(reset),
    .WriteData_i(MEM_WriteData2),
    .inst_i(MEM_inst),
    .bubble_i(MEM_bubble),
	.wD_sel_i(MEM_wD_sel),
	.pc_i(MEM_pc),
	.pc4_i(MEM_pc4),
	.C_i(MEM_C),
	.RegWrite_i(MEM_RegWrite),
	.re1_i(MEM_re1),
	.re2_i(MEM_re2),
    .WriteData_o(WB_WriteData),
    .inst_o(WB_inst),
    .bubble_o(WB_bubble),
	.wD_sel_o(WB_wD_sel),
	.pc_o(WB_pc),
	.pc4_o(WB_pc4),
	.C_o(WB_C),
	.RegWrite_o(WB_RegWrite),
	.re1_o(WB_re1),
	.re2_o(WB_re2)
    );
   
    //WB
    
    Mux_wD Mux_wD_1(
    .wD_sel(MEM_wD_sel),
    .pc4(MEM_pc4),
    .DRAM_i(MEM_WriteData),
    .C(MEM_C),
    .imm(MEM_imm),
    .WriteData(MEM_WriteData2)
    );
    
    //¿ØÖÆµ¥Ôª
    control_unit control_unit_1(
	.jump(jump),
        .inst(ID_inst),
        .pc_sel(ID_pc_sel),
        .ALU_op(ID_ALU_op),
        .RegWrite(ID_RegWrite),
        .ALU_B_sel(ID_ALU_B_sel),
        .Imm_sel(Imm_sel),
        .wr_i(ID_wr_i),
        .wD_sel(ID_wD_sel),
        .re1(ID_re1),
        .re2(ID_re2)
    );
    
    data_hazard_test U_data_hazard_test(
        .reset(reset),
        .IF_inst(IF_inst),
        .ID_inst(ID_inst),
        .EX_inst(EX_inst),
        .MEM_inst(MEM_inst),
        .WB_inst(WB_inst),
        .RegWrite3(EX_RegWrite),
	.RegWrite4(MEM_RegWrite),
	.RegWrite5(WB_RegWrite),
        .re1(ID_re1),
        .re2(ID_re2),
        .case_A1(case_A1),
        .case_B1(case_B1),
        .case_C1(case_C1),
	.case_A2(case_A2),
        .case_B2(case_B2),
        .case_C2(case_C2)
    );
    
    jump_test U_jump_test(
	.inst(EX_inst),
        .branch(EX_branch),
        .pc_sel(EX_pc_sel),
	.bubble(EX_bubble),
	.bubble2(ID_bubble2),
        .jump(jump)
    );
    
    stop_test U_stop_test(
        .inst1(ID_inst),
        .inst2(EX_inst),
	.inst3(MEM_inst),
        .stop(stop)
    );
    
    Mux_ID_bubble U_Mux_ID_bubble(
    .jump(jump),
    .bubble1(ID_bubble1),
    .bubble2(ID_bubble2),
    .bubble(ID_bubble)
   );

endmodule
