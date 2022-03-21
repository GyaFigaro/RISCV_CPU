module EX_MEM(
    input clk,
    input reset,
    input [31:0] C_i,
    input [31:0] rD2_i,
    input wr_i_i,
    input [31:0] inst_i,
    input bubble_i,
input [1:0] wD_sel_i,
input [31:0] pc_i,
input [31:0] pc4_i,
input RegWrite_i,
input [31:0] imm_i,
input re1_i,
	input re2_i,
    output reg [31:0] C_o,
    output reg [31:0] rD2_o,
    output reg wr_i_o,
    output reg [31:0] inst_o,
    output reg bubble_o,
output reg [1:0] wD_sel_o,
output reg [31:0] pc_o,
output reg [31:0] pc4_o,
output reg RegWrite_o,
output reg [31:0] imm_o,
output reg re1_o,
	output reg re2_o
    );
    always @ (posedge clk or negedge reset)
    begin
        if(~reset) 
        begin
            C_o <= 32'h0;
            rD2_o <= 32'h0;
            wr_i_o <= 'h0;  
            inst_o <= 32'h0;
            bubble_o <= 1;
wD_sel_o <= 2'h0;
pc_o <= 32'h0;
pc4_o <= 32'h0;
RegWrite_o <= 0;
imm_o <= 32'h0;
re1_o <= 0;
	re2_o <= 0;
        end
    
        else
        begin    
           C_o <= C_i;
           rD2_o <= rD2_i;
           wr_i_o <= wr_i_i;
           inst_o <= inst_i;
wD_sel_o <= wD_sel_i;
pc_o <= pc_i;
pc4_o <= pc4_i;
imm_o <= imm_i;
RegWrite_o <= RegWrite_i;
re1_o <= re1_i;
re2_o <= re2_i;
           if(bubble_i == 1)
            begin
                bubble_o <= 1;
            end
            else
            begin
                bubble_o <= 0;
            end
        end
    end    
endmodule
