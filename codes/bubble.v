module Mux_ID_bubble(
        input jump,
        input bubble1,
        input bubble2,
        output bubble
    );
    
    assign bubble=(jump == 0)?bubble1:bubble2;
endmodule
