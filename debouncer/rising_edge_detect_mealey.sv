`timescale 1ns / 1ps

module rising_edge_detect_mealy(
    input logic clk,reset,
    input logic level,
    output logic tick
    );
    
    // sdianl declaration
    typedef enum logic [1:0] {zero,one} state_type;
    state_type state_reg,state_next;
    
    // state_register
    always_ff@(posedge clk or posedge reset)
        if(reset)
            state_reg <= zero;
         else
            state_reg <= state_next;
    // next_state_logic
    always_comb
        begin
            tick = 1'b0;
            case(state_reg)
                zero:begin
                    if(level)
                    begin
                        state_next = one;
                        tick = 1'b1;
                    end
                     else
                        state_next = zero;
                     end
                one:begin
                    if(level)
                        state_next = one;
                    else
                        state_next = zero;
                    end
                default: state_next = zero;
                endcase
        end   

endmodule
