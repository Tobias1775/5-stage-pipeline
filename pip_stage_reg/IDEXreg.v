module IDEX(
    clk, 
    rst,
    flushE,
    RegWriteD,
    MemtoRegD,
    MemWriteD,
    ALUControlD,
    ALUSrcD,
    RegDstD,
    RD1D,
    RD2D,
    RegisterRsD,
    RegisterRtD,
    RegisterRdD,
    ExtImmIn,
    IsShiftD,
    ShamtD,
    RegWriteE,
    MemtoRegE,
    MemWriteE,
    ALUControlE,
    ALUSrcE,
    RegDstE,
    RD1E,
    RD2E,
    RegisterRsE,
    RegisterRtE,
    RegisterRdE,
    ExtImmE,
    IsShiftE,
    ShamtE,
    JalE,
    JalD
);

input clk, rst, flushE, RegWriteD, MemtoRegD, MemWriteD, ALUSrcD, RegDstD, IsShiftD, JalD;
input [4:0] ALUControlD, RegisterRsD, RegisterRtD, RegisterRdD, ShamtD;
input [31:0] RD1D, RD2D, ExtImmIn;

output reg RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE, IsShiftE, JalE;
output reg [4:0] ALUControlE, RegisterRsE, RegisterRtE, RegisterRdE, ShamtE;
output reg [31:0] RD1E, RD2E, ExtImmE;

always @(posedge clk) begin
    if (rst || flushE) begin // When flush, clear the register.
        {RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE} <= 0;
        {ALUControlE, RegisterRsE, RegisterRtE, RegisterRdE} <= 0;
        {RD1E, RD2E, ExtImmE, JalE} <= 0;
        IsShiftE <= 0;
        ShamtE <= 0;
    end
    else begin
        RegWriteE   <= RegWriteD;
        MemtoRegE   <= MemtoRegD;
        MemWriteE   <= MemWriteD;
        ALUControlE <= ALUControlD;
        ALUSrcE     <= ALUSrcD;
        RegDstE     <= RegDstD;
        RD1E        <= RD1D;
        RD2E        <= RD2D;
        RegisterRsE <= RegisterRsD;
        RegisterRtE <= RegisterRtD;
        RegisterRdE <= RegisterRdD;
        ExtImmE     <= ExtImmIn;
        IsShiftE    <= IsShiftD;
        ShamtE      <= ShamtD;
        JalE <= JalD;
    end
end
endmodule