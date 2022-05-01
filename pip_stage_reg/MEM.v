module MEM(
    clk,
    rst,
    MemWriteM,
    ZeroM,
    ALUOutM,
    WriteDataM,
    ReadDataM,
    ALUOutMout
);

input clk, rst, MemWriteM, ZeroM;
input [31:0] ALUOutM, WriteDataM;

output [31:0] ReadDataM, ALUOutMout;

MainMemory mem(
    .CLOCK(clk),
    .RESET(rst),
    .ENABLE(MemWriteM),
    .FETCH_ADDRESS(ALUOutM),
    .EDIT_SERIAL({MemWriteM, ALUOutM, WriteDataM}),
    .DATA(ReadDataM)
);


assign ALUOutMout = ALUOutM;
endmodule