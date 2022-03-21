module RF(
    input clk,
    input RegWrite,
	input [31:0] inst2,
    input [31:0] inst5,
    input [31:0] WriteData,
    output  [31:0]  rD1,
    output  [31:0]  rD2

    );
    reg [4:0] rR1;
    reg [4:0] rR2;
    reg [4:0] Rw;
    reg [31:0] register[0:31];
    
    always@(*)
    begin
        rR1 = inst2 [19:15];
        rR2 = inst2 [24:20];
        Rw = inst5 [11:7];
    end
    
    //¶Á
    assign rD1 = register[rR1];
    assign rD2 = register[rR2];

    //Ð´
    always @(posedge clk)
    begin
        if(RegWrite && Rw != 0) 
        begin
            register[Rw] <= WriteData;
        end
    end
   
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
