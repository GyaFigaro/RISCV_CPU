module top(
    input clk,
    input rst_n,
    output        debug_wb_have_inst = 1'b1,   // WB阶段是否有指令 (对单周期CPU，此flag恒为1)
    output [31:0] debug_wb_pc,          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
    output        debug_wb_ena,         // WB阶段的寄存器写使能 (若wb_have_inst=0，此项可为任意值)
    output [4:0]  debug_wb_reg,         // WB阶段写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output [31:0] debug_wb_value        // WB阶段写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)
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
