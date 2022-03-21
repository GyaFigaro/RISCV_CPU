module top(
    input clk,
    input rst_n,
    output        debug_wb_have_inst = 1'b1,   // WB�׶��Ƿ���ָ�� (�Ե�����CPU����flag��Ϊ1)
    output [31:0] debug_wb_pc,          // WB�׶ε�PC (��wb_have_inst=0�������Ϊ����ֵ)
    output        debug_wb_ena,         // WB�׶εļĴ���дʹ�� (��wb_have_inst=0�������Ϊ����ֵ)
    output [4:0]  debug_wb_reg,         // WB�׶�д��ļĴ����� (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
    output [31:0] debug_wb_value        // WB�׶�д��Ĵ�����ֵ (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
    );
    
    wire RegWrite;
    wire [31:0] inst1;
wire [31:0] inst2;
    wire [31:0] pc1;
wire [31:0] pc2;
    wire [31:0] C;
    wire [31:0] rD2;
    wire wr_i;
    wire [31:0] WriteData;
    wire bubble;
wire [31:0] new_WriteData;
    
    cpu cpu_u (
    .clk(clk),
    .reset(rst_n),
    .IF_inst(inst1),
    .MEM_WriteData(WriteData),
    .WB_RegWrite(RegWrite),
    .IF_pc(pc1),
	.WB_pc(pc2),
    .MEM_C(C),
    .MEM_rD2(rD2),
    .MEM_wr_i(wr_i),
    .WB_bubble(bubble),
    .WB_WriteData(new_WriteData),
	.WB_inst(inst2)
   
    );
    
    assign debug_wb_have_inst = (bubble == 0)?1:0;
    assign debug_wb_pc = pc2;
    assign debug_wb_ena = RegWrite;
    assign debug_wb_reg = inst2[11:7];
    assign debug_wb_value = new_WriteData;
   
    inst_mem imem(
        .a(pc1[17:2]),
        .spo(inst1)
    );

    data_mem dmem(
        .clk(clk),
        .a(C[17:2]),
        .spo (WriteData),
        .we(wr_i),
        .d(rD2)
    );
    
endmodule
