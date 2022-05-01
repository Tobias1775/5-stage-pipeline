module EXMEM(
    clk,
    rst,
    RegWriteE,
    MemtoRegE,
    MemWriteE,
    ZeroE,
    ALUOutE,
    WriteDataE,
    WriteRegE,
    RegWriteM,
    MemtoRegM,
    MemWriteM,
    ZeroM,
    ALUOutM,
    WriteDataM,
    WriteRegM,
);

input clk, rst, RegWriteE, MemtoRegE, MemWriteE, ZeroE;
input [4:0] WriteRegE;
input [31:0] ALUOutE, WriteDataE;

output reg RegWriteM, MemtoRegM, MemWriteM,  ZeroM;
output reg [4:0] WriteRegM;
output reg [31:0] ALUOutM, WriteDataM;

always @(posedge clk) begin
    if (rst) begin
        {RegWriteM, MemtoRegM, MemWriteM, ZeroM, WriteRegM, ALUOutM, WriteDataM} <= 0;
    end
    else begin
        RegWriteM <= RegWriteE;
        MemtoRegM <= MemtoRegE;
        MemWriteM <= MemWriteE;
        ZeroM <= ZeroE;
        WriteRegM <= WriteRegE;
        ALUOutM <= ALUOutE;
        WriteDataM <= WriteDataE;
    end
end

endmodule