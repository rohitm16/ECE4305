`timescale 1ns / 1ps
// sync write & async read

module ram_3port#(parameter ADDR_WIDTH = 10, DATA_WIDTH = 8)(
    input logic clk,
    input logic we,
    input logic [ADDR_WIDTH - 1:0] rd_addr1,rd_addr2,
    input logic [ADDR_WIDTH - 1:0] wr_addr,
    input logic [DATA_WIDTH - 1:0] wr_data,
    output logic [DATA_WIDTH - 1:0] rd_data1,rd_data2  
    );
    
    logic [DATA_WIDTH - 1:0] memory [2**ADDR_WIDTH -1:0];
    
    always_ff@(posedge clk)
        begin
            if(we)
                memory [wr_addr] <= wr_data;
        end
        
      assign rd_data1 = memory[rd_addr1];
      assign rd_data2 = memory[rd_addr2];
endmodule
