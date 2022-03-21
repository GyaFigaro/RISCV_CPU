module ID_EX(
    input clk,
    input reset,
    input wr_i_i,
    input jump,
    input stop,
    input  case_A1,
    input  case_B1,
    input  case_C1,
	 input  case_A2,
    input  case_B2,
    input  case_C2,
    input [31:0] EX_to_ID,
    input [31:0] MEM_to_ID,
    input [31:0] WB_to_ID,
    input [1:0] pc_sel_i,
    input [3:0] ALU_op_i,
    input [31:0] A_i,
    //input [31:0] B_i,
    input [31:0] rD2_i,
    input [31:0] inst_i,
    input [31:0] pc_imm_i,
    input bubble_i,
	input [31:0] pc4_i,
	input [1:0] wD_sel_i,
	input [31:0] pc_i,
	input RegWrite_i,
	input [31:0] imm_i,
	input re1_i,
	input re2_i,
	input ALU_B_sel_i,
    output reg wr_i_o,
    output reg [1:0] pc_sel_o,
    output reg [3:0] ALU_op_o,
    output reg [31:0] A_o,
    //output reg [31:0] B_o,
    output reg [31:0] rD2_o,
    output reg [31:0] inst_o,
    output reg [31:0] pc_imm_o,
    output reg bubble_o,
	output reg [31:0] pc4_o,
	output reg [1:0] wD_sel_o,
	output reg [31:0] pc_o,
	output reg RegWrite_o,
	output reg [31:0] imm_o,
	output reg re1_o,
	output reg re2_o,
	output reg ALU_B_sel_o
    );
    always @ (posedge clk or negedge reset)
    begin
        if(~reset) 
        begin
            wr_i_o <= 'h0;
            pc_sel_o <= 2'h0;
            ALU_op_o <= 3'h0;
            A_o <= 32'h0;
            //B_o <= 32'h0;
            rD2_o <= 32'h0;
            inst_o <= 32'h0;
            pc_imm_o <= 32'h0;
            bubble_o <= 1;
	pc4_o <= 32'h0;
	wD_sel_o <= 2'h0;
	pc_o <= 32'h0;
	RegWrite_o <= 0;
	imm_o <= 32'h0;
	re1_o <= 0;
	re2_o <= 0;
	ALU_B_sel_o <= 0;
        end
        else if( stop == 1)
        begin
            wr_i_o <= 'h0;
            pc_sel_o <= 2'h0;
            ALU_op_o <= 3'h0;
            A_o <= 32'h0;
            //B_o <= 32'h0;
            rD2_o <= 32'h0;
            inst_o <= 32'h0;
            pc_imm_o <= 32'h0;
	wD_sel_o <= 2'h0;
	pc4_o <= 32'h0;
	pc_o <= 32'h0;
	RegWrite_o <= 0;
	imm_o <= 32'h0;
	re1_o <= 0;
	re2_o <= 0;
           	ALU_B_sel_o <= 0;
	bubble_o <= 1;
        end
       else if(jump == 1)
	begin
	wr_i_o <= 'h0;
            pc_sel_o <= 2'h0;
            ALU_op_o <= 3'h0;
            A_o <= 32'h0;
            //B_o <= 32'h0;
            rD2_o <= 32'h0;
            inst_o <= 32'h0;
            pc_imm_o <= 32'h0;
	wD_sel_o <= 2'h0;
	pc4_o <= 32'h0;
	pc_o <= 32'h0;
	RegWrite_o <= 0;
	imm_o <= 32'h0;
	re1_o <= 0;
	re2_o <= 0;
	bubble_o <= 1;
	end
    else if(stop==0)//&&jump==0)
        begin  
           if(bubble_i == 1)
            begin
                bubble_o <= 1;
            end
            else
            begin
                bubble_o <= 0;
            end
            
           wr_i_o <= wr_i_i;
           pc_sel_o <= pc_sel_i;
           ALU_op_o <= ALU_op_i;
           
           //rD2_o <= rD2_i;
           inst_o <= inst_i;
           pc_imm_o <= pc_imm_i;
	pc4_o <= pc4_i;
	wD_sel_o <= wD_sel_i;
	pc_o <= pc_i;
	RegWrite_o <= RegWrite_i;
	imm_o <= imm_i;
	re1_o <= re1_i;
	re2_o <= re2_i;
	ALU_B_sel_o <= ALU_B_sel_i;
           if(case_A1 == 1)
           begin
                A_o <= EX_to_ID;
           end
           else if(case_B1 == 1)
           begin
                A_o <= MEM_to_ID;     
           end
           else if(case_C1 == 1 )
           begin
                A_o <= WB_to_ID;
           end
    else
           begin
                A_o <= A_i;
           end
           
           if(case_A2 == 1)
           begin
                //B_o <= EX_to_ID;
	rD2_o<= EX_to_ID; 
           end
           else if(case_B2 == 1)
           begin
               //B_o <= MEM_to_ID;   
	 rD2_o<= MEM_to_ID; 
           end
           else if(case_C2 == 1  )
           begin
               //B_o <= WB_to_ID;
	rD2_o<= WB_to_ID;
           end
           else
           begin
                //B_o <= B_i;
	rD2_o <= rD2_i;
           end 
        end
        else          
	 if(bubble_i == 1)
            begin
                bubble_o <= 1;
            end
            else
            begin
                bubble_o <= 0;
            end;
    end    
endmodule
