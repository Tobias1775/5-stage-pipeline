module MEMWB(
    clk,
    rst,
    RegWriteM,
    MemtoRegM,
    ALUOutMout,
    ReadDataM,
    WriteRegM,
    RegWriteW,
    MemtoRegW,
    ALUOutW,
    ReadDataW,
    WriteRegW
);

input clk, rst, RegWriteM, MemtoRegM;
input [4:0] WriteRegM;
input [31:0] ALUOutMout, ReadDataM;

output reg RegWriteW, MemtoRegW;
output reg [4:0] WriteRegW;
output reg [31:0] ALUOutW, ReadDataW;

always @(posedge clk) begin
    if (rst) begin
        RegWriteW <= 0;
        MemtoRegW <= 0;
        WriteRegW <= 0;
        ALUOutW <= 0;
        ReadDataW <= 0;
    end
    else begin
        RegWriteW <= RegWriteM;
        MemtoRegW <= MemtoRegM;
        WriteRegW <= WriteRegM;
        ALUOutW <= ALUOutMout;
        ReadDataW <= ReadDataM;
    end
end
endmodule