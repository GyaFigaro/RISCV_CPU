module Mux_wD(
    input [1:0]wD_sel,
    input [31:0] pc4,
    input [31:0] DRAM_i,
    input [31:0] imm,
    input [31:0] C,
    output reg [31:0] WriteData
    );
    always@ (*)
    begin
        if(wD_sel == 2'b00)              //J & jal
        begin
            WriteData = pc4;
        end
        else if(wD_sel == 2'b01)
        begin
            WriteData = C;
        end
        else if(wD_sel == 2'b10)      //S
        begin
            WriteData = DRAM_i;
        end
        else if(wD_sel == 2'b11)     //U
        begin
            WriteData = imm;
        end
    end
    
endmodule
