`timescale 1ns / 1ps

module binary_counter
    #(parameter N = 8)(
    input logic clk,reset,
    input logic en,
    input logic [N-1:0] q,
    output logic max_tick
    );
    
    // signal declaration
    logic[N-1:0]r_next,r_reg;
    
    //Register Segment
    always_ff@(posedge clk, posedge reset)
    begin
        if(reset)
            r_reg <= 0;
        else
            r_reg <=r_next;
    end
    
    //next state logic
    assign r_next = en?r_reg +1:r_reg;
    
    // output logic
    assign q= r_reg;
    assign max_tick = (r_reg == 2**(N-1))?1'b1:1'b0;
endmodule
