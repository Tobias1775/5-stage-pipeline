`include "pip_stage_reg\\IF.v"
`include "pip_stage_reg\\ID.v"
`include "pip_stage_reg\\EX.v"
`include "pip_stage_reg\\MEM.v"
`include "pip_stage_reg\\WB.v"
`include "pip_stage_reg\\IFIDreg.v"
`include "pip_stage_reg\\IDEXreg.v"
`include "pip_stage_reg\\EXMEMreg.v"
`include "pip_stage_reg\\MEMWBreg.v"
`include "module\\adder.v"
`include "module\\ALU.v"
`include "module\\ControlUnit.v"
`include "module\\ForwardingUnit.v"
`include "module\\HazardDetectUnit.v"
`include "module\\InstructionRAM.v"
`include "module\\MainMemory.v"
`include "module\\mux.v"
`include "module\\register.v"
`include "module\\RegisterFile.v"
`include "module\\signextend.v"

module CPU (CLOCK, rst);

input CLOCK, rst;

wire [31:0] PCPlus4F;

wire [31:0] InstructionF;

wire [31:0] regout1D, regout2D;
wire [31:0] RD1D, RD2D;
wire [31:0] PCBranchD, JumpTarget;
wire [31:0] PCPlus4D, InstructionD;
wire [31:0] signimmD;
wire [4:0] ALUControlD, ShamtD; 
wire [4:0] RegisterRsD, RegisterRtD, RegisterRdD;
wire RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD, RegDstD, JumpD, JalD, JrD, IsShiftD, PCSrcD;

wire [31:0] RD1E, RD2E, signimmE, ALUOutE, WriteDataE;
wire [4:0] ALUControlE, ShamtE;
wire [4:0] RegisterRsE, RegisterRtE, RegisterRdE, WriteRegE;
wire RegWriteE, MemtoRegE, MemWriteE, ALUSrcE,RegDstE, IsShiftE;
wire JalE, ZeroE;


wire [31:0] ALUOutM, WriteDataM, ReadDataM, ALUOutMout;
wire [4:0] WriteRegM; 
wire RegWriteM, MemtoRegM, MemWriteM, ZeroM;

wire [31:0] ALUOutW, ReadDataW, ResultW;
wire [4:0] WriteRegW;
wire RegWriteW, MemtoRegW;

wire [1:0] ForwardA, ForwardB;
wire ForwardC, ForwardD;
wire IFflush;
wire hazard;

ForwardingUnit forward(
    .RegisterRsD(RegisterRsD),
    .RegisterRtD(RegisterRtD),
    .RegisterRsE(RegisterRsE),
    .RegisterRtE(RegisterRtE),
    .WriteRegE(RegisterRdE),
    .WriteRegM(WriteRegM),
    .WriteRegW(WriteRegW),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .BranchD(BranchD),
    .JrD(JrD),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
    .ForwardC(ForwardC),
    .ForwardD(ForwardD)
);

HazardDetect hazardunit(
    .MemtoRegE(MemtoRegE),
    .MemtoRegM(MemtoRegM),
    .BranchD(BranchD),
    .JumpD(JumpD),
    .JalD(JalD),
    .JrD(JrD),
    .PCSrcD(PCSrcD),
    .RegisterRtE(RegisterRtE),
    .RegisterRsD(RegisterRsD),
    .RegisterRtD(RegisterRtD),
    .WriteRegE(WriteRegE),
    .WriteRegM(WriteRegM),
    .RegWriteE(RegWriteE),
    .ishazard(hazard),
    .IFflush(IFflush)
);

Regfile regfile(
    .clk(CLOCK),
    .rst(rst),
    .WriteEn(RegWriteW),
    .Src1(InstructionD[25:21]),
    .Src2(InstructionD[20:16]),
    .WriteData(ResultW),
    .WriteReg(WriteRegW),
    //out
    .regout1(regout1D),
    .regout2(regout2D)
);

IF IFStage(
    .clk(CLOCK),
    .rst(rst),
    .PCBranchD(PCBranchD),
    .PCSrcD(PCSrcD),
    .JumpD(JumpD),
    .JalD(JalD),
    .JrD(JrD),
    .stall(hazard),
    .PCPlus4Fin(PCPlus4F),
    .PCPlus4Fout(PCPlus4F),
    .instruction(InstructionF),
    .JumpAddr(JumpTarget)
);

IFID IFIDreg(
    .clk(CLOCK),
    .rst(rst),
    .stallD(hazard),
    .IFflush(IFflush),
    .PCPlus4F(PCPlus4F),
    .InstructionF(InstructionF),
    //out
    .PCPlus4D(PCPlus4D),
    .InstructionD(InstructionD)
);

ID IDStage(
    .clk(CLOCK),
    .rst(rst),
    .InstructionD(InstructionD),
    .regin1(regout1D),
    .regin2(regout2D),
    .PCPlus4D(PCPlus4D),
    .ALUOutM(ALUOutM),
    .ForwardC(ForwardC),
    .ForwardD(ForwardD),
    //out
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .BranchD(BranchD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .JumpD(JumpD),
    .JalD(JalD),
    .JrD(JrD),
    .IsShiftD(IsShiftD),
    .PCSrcD(PCSrcD),
    .ALUControlD(ALUControlD),
    .RegisterRsD(RegisterRsD),
    .RegisterRdD(RegisterRdD),
    .RegisterRtD(RegisterRtD),
    .ShamtD(ShamtD),
    .RD1Dout(RD1D),
    .RD2Dout(RD2D),
    .ExtImmOut(signimmD),
    .PCBranchD(PCBranchD),
    .JumpTarget(JumpTarget)
);

IDEX IDEXreg(
    .clk(CLOCK),
    .rst(rst),
    .flushE(hazard),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .IsShiftD(IsShiftD),
    .JalD(JalD),
    .ALUControlD(ALUControlD),
    .RegisterRsD(RegisterRsD),
    .RegisterRtD(RegisterRtD),
    .RegisterRdD(RegisterRdD),
    .ShamtD(ShamtD),
    .RD1D(RD1D),
    .RD2D(RD2D),
    .ExtImmIn(signimmD),
    //out
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .ALUSrcE(ALUSrcE),
    .RegDstE(RegDstE),
    .IsShiftE(IsShiftE),
    .JalE(JalE),
    .ALUControlE(ALUControlE),
    .RegisterRsE(RegisterRsE),
    .RegisterRtE(RegisterRtE),
    .RegisterRdE(RegisterRdE),
    .ShamtE(ShamtE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .ExtImmE(signimmE)
);

EX EXStage(
    .clk(CLOCK),
    .rst(rst),
    .ALUSrcE(ALUSrcE),
    .RegDstE(RegDstE),
    .IsShiftE(IsShiftE),
    .JalE(JalE),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
    .ALUControlE(ALUControlE),
    .ShamtE(ShamtE),
    .RegisterRtE(RegisterRtE),
    .RegisterRdE(RegisterRdE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .ExtImmE(signimmE),
    .ALUOutM(ALUOutM),
    .ResultW(ResultW),
    //out
    .ZeroE(ZeroE),
    .WriteRegE(WriteRegE),
    .ALUOutE(ALUOutE),
    .WriteDataE(WriteDataE)
);

EXMEM EXMEMEreg(
    .clk(CLOCK),
    .rst(rst),
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .ZeroE(ZeroE),
    .WriteRegE(WriteRegE),
    .ALUOutE(ALUOutE),
    .WriteDataE(WriteDataE),
    //out
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .MemWriteM(MemWriteM),
    .ZeroM(ZeroM),
    .WriteRegM(WriteRegM),
    .ALUOutM(ALUOutM),
    .WriteDataM(WriteDataM)
);

MEM MEMStage(
    .clk(CLOCK),
    .rst(rst),
    .MemWriteM(MemWriteM),
    .ZeroM(ZeroM),
    .ALUOutM(ALUOutM),
    .WriteDataM(WriteDataM),
    //out
    .ReadDataM(ReadDataM),
    .ALUOutMout(ALUOutMout)
);

MEMWB MEMWBReg(
    .clk(CLOCK),
    .rst(rst),
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .WriteRegM(WriteRegM),
    .ALUOutMout(ALUOutMout),
    .ReadDataM(ReadDataM),
    //out
    .RegWriteW(RegWriteW),
    .MemtoRegW(MemtoRegW),
    .WriteRegW(WriteRegW),
    .ALUOutW(ALUOutW),
    .ReadDataW(ReadDataW)
);

WB WBStage(
    .MemtoRegW(MemtoRegW),
    .ALUOutW(ALUOutW),
    .ReadDataW(ReadDataW),
    //out
    .ResultW(ResultW)
);
endmodule