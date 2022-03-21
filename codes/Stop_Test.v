module stop_test(
    input [31:0] inst1,//ID_isnt
    input [31:0] inst2,//EX_inst
 	input [31:0] inst3,	
    output reg stop
    );
    wire [6:0] EX_opcode;
    assign EX_opcode = inst2[6:0];
    always@(*)
    begin
        if(EX_opcode == 7'b0000011)
        begin
            if((inst1[24:20] == inst2[11:7])||(inst1[19:15] == inst2[11:7]))
            begin
                stop = 1;
            end
            else
            begin
                stop = 0;
            end
        end
        else
        begin
            stop = 0;
        end
    end
    
    
    
endmodule
