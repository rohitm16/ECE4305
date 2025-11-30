`timescale 1ns / 1ps


module time_mux_disp(
    input logic [5:0] in0,
    input logic [5:0] in1,
    input logic [5:0] in2,
    input logic [5:0] in3,
    input logic [5:0] in4,
    input logic [5:0] in5,
    input logic [5:0] in6,
    input logic [5:0] in7,
    input logic clk,
    input logic [7:0] sseg,
    input logic dp,
    output logic [7:0] an    
    );
    
    // to display [0] is for dp, [4:1] is for hex to be decoded, [5] is for enb/disable ofr sseg
    logic [5:0] to_display;
    logic [19:0] counter_output;
    logic [2:0] controller_counter;
    
    binary_counter #(.N(20)) c0(
    .clk(clk),
    .reset(1'b0),
    .en(1'b1),
    .q(counter_output),
    .max_tick()
    );
    
    mux #(.BITS(6)) mux0(
    .sel(controller_counter),
    .mux_out(to_display)
    );
    
    decoder #(.N(3)) dec0(
    .in(controller_counter),
    .enable(1'b1),
    .an(an)
    );
    
    hex2sseg sseg0(
    .hex_in(to_display[4:1]),
    .enable(to_display[5]),
    .sseg(sseg)
    );
    
    assign dp = to_display[0];
    
endmodule
