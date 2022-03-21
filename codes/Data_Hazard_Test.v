
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 14:39:04
// Design Name: 
// Module Name: data_hazard_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_hazard_test(
    input reset,
    input [31:0] IF_inst,
    input [31:0] ID_inst,
    input [31:0] EX_inst,
    input [31:0] MEM_inst,
    input [31:0] WB_inst,
    input RegWrite3,
	input RegWrite4,
	input RegWrite5,
    input re1,
    input re2,
	//input bubble,
    output reg   case_A1,
    output reg  case_B1,
    output reg case_C1,
output reg   case_A2,
    output reg  case_B2,
    output reg case_C2
    );
    reg [4:0] ID_RS1;
    reg [4:0] ID_RS2;
    reg [4:0] EX_RD;
    reg [4:0] MEM_RD;
    reg [4:0] WB_RD;
    reg [6:0] ID_opcode;
    always@(*)
    begin
        ID_RS1 = ID_inst[19:15];
        ID_RS2 = ID_inst[24:20];
        ID_opcode = ID_inst[6:0];
        EX_RD = EX_inst[11:7];
        MEM_RD = MEM_inst[11:7];
        WB_RD = WB_inst[11:7];
        if(reset != 1)
        begin
            case_A1 = 0;
            case_B1 = 0;
            case_C1 = 0;
            case_A2 = 0;
            case_B2 = 0;
            case_C2 = 0;
            
        end
        if((ID_RS1 == EX_RD ) && (RegWrite3 == 1)&&(re1 == 1) &&(ID_RS1 != 0))
        begin
            case_A1 = 1;
        end
	else 
	begin
		case_A1 = 0;
	end

        if((ID_RS2 == EX_RD) && (RegWrite3 == 1)&&(re2 == 1)  &&(ID_RS2 != 0))
        begin
            case_A2 = 1;
        end
        else
        begin
            case_A2 = 0;
        end
        if((ID_RS1 == MEM_RD) && (RegWrite4 == 1) &&(re1 == 1) &&(ID_RS1!= 0))
        begin
            case_B1 = 1;
        end
	else 
	begin
	case_B1 = 0;
	end
        if((ID_RS2== MEM_RD) && (RegWrite4 == 1)&&(re2 == 1)  &&(ID_RS2 != 0))
        begin
            case_B2 = 1;
        end
        else
        begin
            case_B2 = 0;
        end
        if((ID_RS1 == WB_RD) && (RegWrite5 == 1)&&(re1 == 1)  &&(ID_RS1 != 0))
        begin
            case_C1 = 1;
        end
	else 
	begin
                      case_C1 = 0;
	end
        if((ID_RS2 == WB_RD) && (RegWrite5 == 1) &&(re2 == 1) &&(ID_RS2 != 0))
        begin
            case_C2 = 1;
        end
        else
        begin
            case_C2 = 0;
        end
    
    end
    
endmodule
