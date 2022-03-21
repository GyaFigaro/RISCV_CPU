module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0]ALU_op,
    output reg flag,
    output reg [31:0] C
    );
    wire [31:0] shifter [2:0];
    Shifter shifter0(
            .A(A),
            .B(B),
            .caze(2'b00),
            .shifter(shifter[0])
           );
      Shifter shifter1(
            .A(A),
            .B(B),
            .caze(2'b01),
            .shifter(shifter[1])
           );
       Shifter shifter2(
            .A(A),
            .B(B),
            .caze(2'b10),
            .shifter(shifter[2])
           );
    
    always@(*)
    begin
        case(ALU_op)
            4'b0000:    
            begin
                C = A + B;
	flag = 0;
            end
            4'b0001:
            begin
                C = A - B;
	flag = 0;
            end  
            4'b0010:
            begin
                C = A ^ B;
	flag = 0;
            end 
            4'b0011:
            begin
                C = A | B;
	flag = 0;
            end 
            4'b0100:
            begin
                C = A & B;
	flag = 0;
            end
            
            4'b0101:              //beq
            begin
                 C = A - B;
                if(C == 0)
                begin
                    flag = 1;
                end
                else
                begin
                    flag = 0;
                end
            end
            4'b0110:               //bne
            begin
                 C = A - B;
                if(C != 0)
                begin
                    flag = 1;
                end
                else
                begin
                    flag = 0;
                end
            end
            4'b0111:              //blt
            begin
                 C = A - B;
                if(C > 32'h80000000)
                begin
                    flag = 1;
                end
                else
                begin
                    flag = 0;
                end
            end
            4'b1000:            //bge
            begin
                 C = A - B;
                if(C < 32'h80000000 || C == 32'h00000000)
                begin
                    flag = 1;
                end
                else
                begin
                    flag = 0;
                end
            end
             4'b1001:
            begin
                C = shifter[0];
	flag = 0;
            end
            4'b1010:
            begin
                C = shifter[1];
	flag = 0;
            end
            4'b1011:
            begin
                C = shifter[2];
	flag = 0;
            end
            4'b1100:           //lui
            begin
                C = B;
	flag = 0;
            end
                 
    
        endcase
    end
    
    
    
endmodule
