module EX (
    clk,
    rst,
    ForwardA,
    ForwardB,
    ALUControlE,
    ALUSrcE,
    RegDstE,
    IsShiftE,
    JalE,
    ShamtE,
    RD1E,
    RD2E,
    RegisterRtE,
    RegisterRdE,
    ExtImmE,
    ALUOutE,
    WriteDataE,
    WriteRegE,
    ZeroE,
    ALUOutM,
    ResultW
);

input clk, rst, ALUSrcE, RegDstE, IsShiftE, JalE;
input [1:0] ForwardA, ForwardB;
input [4:0] ALUControlE, ShamtE, RegisterRtE, RegisterRdE;
input [31:0] RD1E, RD2E, ExtImmE, ALUOutM, ResultW;

output ZeroE;
output [4:0] WriteRegE;
output [31:0] ALUOutE, WriteDataE;

wire [31:0] SrcAE, SrcBE, SrcAin1, SrcBin1;

// Select alu source1 input is shift amount or rs.
mux2to1 shamtmux(
    .in1(RD1E), 
    .in2({{27{ShamtE[4]}},ShamtE[4:0]}),
    .sel(IsShiftE),
    .out(SrcAin1)
);

// select alu source 2 is immediate number or rt/forward data.
mux2to1 immmux(
    .in1(SrcBin1),
    .in2(ExtImmE),
    .sel(ALUSrcE),
    .out(SrcBE)
);


// Select the destination register.
dstregmux3to1 DstReg(
    .in1(RegisterRtE),
    .in2(RegisterRdE),
    .in3(5'd31),
    .sel({JalE,RegDstE}),
    .out(WriteRegE)
);

// Select the ALU source1.
mux3to1 SrcAmux(
    .in1(SrcAin1),
    .in2(ResultW),
    .in3(ALUOutM),
    .sel(ForwardA),
    .out(SrcAE)
);
// Select the ALU source2.
mux3to1 SrcBmux(
    .in1(RD2E),
    .in2(ResultW),
    .in3(ALUOutM),
    .sel(ForwardB),
    .out(SrcBin1)
);
// ALU operation.
ALU ALU(
    .SrcA(SrcAE),
    .SrcB(SrcBE),
    .ALUControl(ALUControlE),
    .ALUOut(ALUOutE),
    .Zero(ZeroE)
);

assign WriteDataE = SrcBin1;

endmodule