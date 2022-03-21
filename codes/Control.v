module control_unit(
	input jump,
        input [31:0] inst,
        output reg [1:0] pc_sel,
        output reg ALU_B_sel,
        output reg wr_i,
        output reg RegWrite,
        output reg [3:0] ALU_op,
        output reg [2:0] Imm_sel,
        output reg [1:0]wD_sel,
        output reg re1,
        output reg re2
      );
      wire [6:0] opcode;
      wire [6:0] funct7;
      wire [2:0] funct3;
      assign opcode = inst[6:0];
      assign funct7 = inst[31:25];
      assign funct3 = inst[14:12]; 
      always@(*)
      begin
	if(jump == 0)
	begin
        case(opcode)
            7'b0110011:
                begin
                    if(funct7 == 7'b0000000)
                    begin
                        if(funct3 == 3'b000)
                        begin//ADD
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `ADD;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                        end
                        else if(funct3 == 3'b111)
                        begin//AND
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `AND;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                        end
                        else if(funct3 == 3'b110)
                        begin//OR
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `OR;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                        end
                        else if(funct3 == 3'b100)
                        begin//XOR
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `XOR;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                        end
                        else if(funct3 == 3'b001)
                        begin//SLL
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `SLL;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                        end
                        else if(funct3 == 3'b101)
                        begin//SRL
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `SRL;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                        end
                    end
                    else if(funct7 == 7'b0100000)
                    begin
                        if(funct3 == 3'b000)
                        begin//SUB
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `SUB;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                         end
                         else if(funct3 == 3'b101)
                         begin//SRA
                            pc_sel = 2'b00;
                            ALU_B_sel = 1;
                            wr_i = 0;
                            RegWrite = 1;
                            ALU_op = `SRA;
                            Imm_sel = 3'b000;
                            wD_sel = 2'b01;
                            re1 = 1;
                            re2 = 1;
                         end
                    end
                end
            7'b0010011:
                if(funct3 == 3'b000)
                begin//ADDI
                    pc_sel = 2'b00;
                    ALU_B_sel = 0;
                    wr_i = 0;
                    RegWrite = 1;
                    ALU_op = `ADD;
                    Imm_sel = 3'b000;
                    wD_sel = 2'b01;
                    re1 = 1;
                    re2 = 0;
                end
                else if(funct3 == 3'b111)
                begin//ANDI
                    pc_sel = 2'b00;
                    ALU_B_sel = 0;
                    wr_i = 0;
                    RegWrite = 1;
                    ALU_op = `AND;
                    Imm_sel = 3'b000;
                    wD_sel = 2'b01;
                    re1 = 1;
                    re2 = 0;
                end
                else if(funct3 == 3'b110)
                begin//ORI
                    pc_sel = 2'b00;
                    ALU_B_sel = 0;
                    wr_i = 0;
                    RegWrite = 1;
                    ALU_op = `OR;
                    Imm_sel = 3'b000;
                    wD_sel = 2'b01;
                    re1 = 1;
                    re2 = 0;
                end
                else if(funct3 == 3'b100)
                begin//XORI
                    pc_sel = 2'b00;
                    ALU_B_sel = 0;
                    wr_i = 0;
                    RegWrite = 1;
                    ALU_op = `XOR;
                    Imm_sel = 3'b000;
                    wD_sel = 2'b01;
                    re1 = 1;
                    re2 = 0;
                end
                else if(funct3 == 3'b001)
                begin//SLLI
                    pc_sel = 2'b00;
                    ALU_B_sel = 0;
                    wr_i = 0;
                    RegWrite = 1;
                    ALU_op = `SLL;
                    Imm_sel = 3'b000;
                    wD_sel = 2'b01;
                    re1 = 1;
                    re2 = 0;
                end
                else if(funct3 == 3'b101)
                begin
                   if(funct7 == 7'b0000000)
                   begin//SRLI
                        pc_sel = 2'b00;
                        ALU_B_sel = 0;
                        wr_i = 0;
                        RegWrite = 1;
                        ALU_op = `SRL;
                        Imm_sel = 3'b000;
                        wD_sel = 2'b01;
                        re1 = 1;
                        re2 = 0;
                   end
                   else if(funct7 == 7'b0100000)
                   begin//SRAI
                        pc_sel = 2'b00;
                        ALU_B_sel = 0;
                        wr_i = 0;
                        RegWrite = 1;
                        ALU_op = `SRA;
                        Imm_sel = 3'b000;
                        wD_sel = 2'b01;
                        re1 = 1;
                        re2 = 0;
                   end
                end
            7'b0000011://lw
            begin
                pc_sel = 2'b00;
                ALU_B_sel = 0;
                wr_i = 0;
                RegWrite = 1;
                ALU_op = `ADD;
                Imm_sel = 3'b000;
                wD_sel = 2'b10;
                re1 = 1;
                re2 = 0;
            end
            7'b1100111:
            begin//jalr
                pc_sel = 2'b11;
                ALU_B_sel = 0;
                wr_i = 0;
                RegWrite = 1;
                ALU_op = `ADD;
                Imm_sel = 3'b000;
                wD_sel = 2'b00;
                re1 = 1;
                re2 = 0;
            end
            7'b0100011:
            begin//sw
                pc_sel = 2'b00;
                ALU_B_sel = 0;
                wr_i = 1;
                RegWrite = 0;
                ALU_op = `ADD;
                Imm_sel = 3'b001;
                wD_sel = 2'b00;
                re1 = 1;
                re2 = 1;
            end
            7'b1100011:
            begin
                if(funct3 == 3'b000)
                begin//BEQ
                    pc_sel = 2'b01;
                    ALU_B_sel = 1;
                    wr_i = 0;
                    RegWrite = 0;
                    ALU_op = `BEQ;
                    Imm_sel = 3'b010;
                    wD_sel = 2'b00;
                    re1 = 1;
                    re2 = 1;
                end
                else if(funct3 == 3'b001)
                begin//BNE
                    pc_sel = 2'b01;
                    ALU_B_sel = 1;
                    wr_i = 0;
                    RegWrite = 0;
                    ALU_op = `BNE;
                    Imm_sel = 3'b010;
                    wD_sel = 2'b00;
                    re1 = 1;
                    re2 = 1;
                end
                else if(funct3 == 3'b100)
                begin//BLT
                    pc_sel = 2'b01;
                    ALU_B_sel = 1;
                    wr_i = 0;
                    RegWrite = 0;
                    ALU_op = `BLT;
                    Imm_sel = 3'b010;
                    wD_sel = 2'b00;
                    re1 = 1;
                    re2 = 1;
                end
                else if(funct3 == 3'b101)
                begin//BGE
                    pc_sel = 2'b01;
                    ALU_B_sel = 1;
                    wr_i = 0;
                    RegWrite = 0;
                    ALU_op = `BGE;
                    Imm_sel = 3'b010;
                    wD_sel = 2'b00;
                    re1 = 1;
                    re2 = 1;
                end
            end
            7'b0110111:
            begin//lui
                pc_sel = 2'b00;
                ALU_B_sel = 0;
                wr_i = 0;
                RegWrite = 1;
                ALU_op = `LUI;
                Imm_sel = 3'b100;
                wD_sel = 2'b11;
                re1 = 0;
                re2 = 0;
            end
            7'b1101111:
            begin//jal
                pc_sel = 2'b10;
                ALU_B_sel = 1;
                wr_i = 0;
                RegWrite = 1;
                ALU_op = `ADD;
                Imm_sel = 3'b011;
                wD_sel = 2'b00;
                re1 = 0;
                re2 = 0;
            end
        endcase
	end
else
	begin
	pc_sel = 0;
                ALU_B_sel = 0;
                wr_i = 0;
                RegWrite = 0;
                ALU_op = 0;
                Imm_sel = 0;
                wD_sel = 0;
                re1 = 0;
                re2 = 0;
	end
      end    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule


