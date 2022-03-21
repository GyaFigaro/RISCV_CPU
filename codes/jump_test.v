module jump_test(
	input [31:0] inst,//IF_inst
    input branch,//EX_branch
    input [1:0] pc_sel,//EX_pc_sel
input bubble,
	output reg bubble2,
    output reg jump//IF_jump
	
    );
    reg pc_sel_2;//=1 ‘ÚÕ£∂Ÿ
    
    always@(*)
    begin
        if(pc_sel == 2'b00)
        begin
            jump = 0;
	bubble2 = 0;
        end  
        else if(pc_sel == 2'b01)
        begin
            if(branch == 1 && inst[6:0] == 7'b1100011)
            begin
               	bubble2 = 1;
                jump = 1;
            end
            else
            begin
	bubble2 = 0;
                jump = 0;
            end    
        end
        else 
	begin
	if(inst[6:0] == 7'b1100111 || inst[6:0] == 7'b1101111)
	 begin
	bubble2 = 1;
                jump = 1;
	end
	else 
	begin
	bubble2 = 0;
                jump = 0;
	end
	end
	
        
    end
endmodule
