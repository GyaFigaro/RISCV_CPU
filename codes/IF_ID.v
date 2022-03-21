module IF_ID(
    input clk,
    input reset,
    input jump,
    input stop,
    input [31:0] pc_i,
    input [31:0] pc4_i,
    input [31:0] inst_i,
    output reg [31:0] pc_o,
    output reg [31:0] pc4_o,
    output reg [31:0] inst_o,
    output reg bubble
    );
    always @ (posedge clk or negedge reset)
    begin
        if(~reset) 
        begin
            pc_o <= 32'h0;
            pc4_o <= 32'h0;
            inst_o <= 32'h0;
           bubble <= 1;
	
        end
        else if (stop == 1&&jump ==0)
        begin
            pc_o <= pc_o;
            pc4_o <= pc4_o;
            inst_o <= inst_o;
            bubble <= 0;
        end
        else if(stop == 0&&jump ==0)
        begin    
            pc_o <= pc_i;
            pc4_o <= pc4_i;
            inst_o <= inst_i;
            bubble <= 0;
        end
	else if(jump == 1)
	begin
	pc_o <= 0;
            pc4_o <= 0;
            inst_o <= 0;
            bubble <= 1;
	end
       else
	bubble <= 0;
	
	
end 


endmodule
