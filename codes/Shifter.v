module Shifter(
        input [31:0] A,
        input [31:0] B,
        input [1:0] caze,
        output [31:0] shifter
    );
    
    reg [31:0] temp;
    wire [4:0] b;
    assign b = B[4:0];
    assign shifter = temp;
    always@(*)
    begin
        case(caze)
            2'b00://¬ﬂº≠◊Û“∆
            begin
                temp = b[0] ? {A[30:0],1'b0} : A ;
                temp = b[1] ? {temp[29:0],2'b0} : temp;
                temp = b[2] ? {temp[27:0],4'b0} : temp;
                temp = b[3] ? {temp[23:0],8'b0} : temp;
                temp = b[4] ? {temp[15:0],16'b0} : temp; 
            end
            
            2'b01://¬ﬂº≠”““∆
            begin
                temp = b[0] ? {1'b0, A[31:1]} : A;
                temp = b[1] ? {2'b0, temp[31:2]} : temp;
                temp = b[2] ? {4'b0, temp[31:4]} : temp;
                temp = b[3] ? {8'b0, temp[31:8]} : temp;
                temp = b[4] ? {16'b0, temp[31:16]} : temp;
            end
            
            2'b10://À„ ı”““∆
            begin
                temp = b[0] ? {{A[31]}, A[31:1]} : A;
                temp = b[1] ? {{2{A[31]}}, temp[31:2]} : temp;
                temp = b[2] ? {{4{A[31]}}, temp[31:4]} : temp;
                temp = b[3] ? {{8{A[31]}}, temp[31:8]} : temp;
                temp = b[4] ? {{16{A[31]}}, temp[31:16]} : temp;
            end
        
        endcase
    end
    
    
    
    
    
    
    
    
    
endmodule
