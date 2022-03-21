module pc(
    input clk,
    input reset,
    input [31:0] new_pc,
	input stop,
    output reg [31:0] pc 
    );
    initial
    begin
        pc = -4;
    end
    always @(posedge clk or posedge reset)
    begin
        if(reset != 1)
        begin
           pc <= -4;
        end
	else if(stop == 1)
	begin
		pc <= pc;
	end
        else begin
            pc <= new_pc;
        end
    end
endmodule
