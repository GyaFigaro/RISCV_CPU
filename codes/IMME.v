module IMM(
    input [31:0] inst,
    input [2:0] Imm_sel,       
    output reg [31:0] imm
    );
    reg first;
    
always@(*)
begin
    case(Imm_sel)
        3'b000:                     //I
        begin
            imm[11:0] = inst [31:20];
            if(inst[31] == 1)
            begin
                imm[31:12] = 20'hfffff;
            end
            else if(inst[31] == 0)
            begin
                imm[31:12] = 20'h00000;
            end
        end
        
        3'b001:                      //S
        begin
            imm[4:0] = inst[11:7];
            imm[11:5] = inst[31:25];
            if(inst[31] == 1)
            begin
                imm[31:12] = 20'hfffff;
            end
            else if(inst[31] == 0)
            begin
                imm[31:12] = 20'h00000;
            end
        end
        
        3'b010:                       //B
        begin
            imm[0] = 0;
            imm[4:1] = inst[11:8];
            imm[10:5] = inst[30:25];
            imm[11] = inst[7];
            if(inst[31] == 1)
            begin
                imm[31:12] = 20'hfffff;
            end
            else if(inst[31] == 0)
            begin
                imm[31:12] = 20'h00000;
            end
        end
        
        3'b011:                 //J
        begin
            imm[0] = 0;
            imm[19:12] = inst[19:12];
            imm[11] = inst[20];
            imm[10:1] = inst[30:21];
            imm[20] = inst[31];
            if(inst[31] == 1)
            begin
                imm[31:20] = 12'hfff;
            end
            else if(inst[31] == 0)
            begin
                imm[31:20] = 12'h000;
            end
        
        end
        
        3'b100:                //U
        begin
            imm[31:12] = inst[31:12];
            imm[11:0] = 12'h000;
        end
        
   endcase 
end
endmodule
