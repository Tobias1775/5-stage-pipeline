
module ID(
    clk, 
    rst, 
    InstructionD, 
    ALUOutM,
    PCPlus4D,
    RegWriteD, 
    MemtoRegD, 
    MemWriteD, 
    ALUControlD, 
    ALUSrcD, 
    RegDstD, 
    JumpD, 
    JalD, 
    JrD, 
    IsShiftD,
    regin1, 
    regin2, 
    PCPlus4D,
    RD1Dout, 
    RD2Dout, 
    RegisterRsD, 
    RegisterRtD, 
    RegisterRdD, 
    ExtImmOut,
    JumpTarget,
    ShamtD,
    PCBranchD,
    BranchD,
    PCSrcD,
    ForwardC,
    ForwardD
);

input clk, rst, ForwardC, ForwardD;
input [31:0] InstructionD, regin1, regin2, PCPlus4D, ALUOutM;
output RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD, RegDstD, JumpD, JalD, JrD, IsShiftD, PCSrcD;
output [4:0] ALUControlD, RegisterRsD, RegisterRtD, RegisterRdD, ShamtD;
output [31:0] RD1Dout, RD2Dout, ExtImmOut, PCBranchD, JumpTarget;

wire EqualD;
wire [31:0] equalsrc1, equalsrc2;
wire[31:0] jrtarget, jtarget;
wire [31:0] RD1D, RD2D;

// Control unit.
ControlUnit ctrunit(
    .Op(InstructionD[31:26]),
    .Funct(InstructionD[5:0]),
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
    .ALUControlD(ALUControlD)
);

Signextend Signextend(
    .in(InstructionD[15:0]),
    .out(ExtImmOut)
);
// Calculate the branch address.
adder branchCalc(
    .in1(PCPlus4D),
    .in2(ExtImmOut<<2),
    .out(PCBranchD)
);

// Select the first source for comparison in branch instruction.
mux2to1 eqsrc1mux(
    .in1(RD1D),
    .in2(ALUOutM),
    .sel(ForwardC),
    .out(equalsrc1)
);

// Select the second source for comparison in branch instruction.
mux2to1 eqsrc2mux(
    .in1(RD2D),
    .in2(ALUOutM),
    .sel(ForwardD),
    .out(equalsrc2)
);

// Select the jump address.
mux2to1 jumptargetmux(
    .in1(jtarget),
    .in2(jrtarget),
    .sel(JrD),
    .out(JumpTarget)
);

// Select the write data.
mux2to1 jalmux(
    .in1(RD2D),
    .in2(PCPlus4D),
    .sel(JalD),
    .out(RD2Dout)
);

// Select the jump address considering JR instruction.
mux2to1 jrtargetmux(
    .in1(RD1D),
    .in2(ALUOutM),
    .sel(ForwardC),
    .out(RD1Dout)
);

assign jrtarget = RD1Dout;
assign jtarget = {PCPlus4D[31:28],InstructionD[25:0],{2'b0}};
assign EqualD = (ALUControlD == 5'd20)? (equalsrc1 == equalsrc2):(equalsrc1 != equalsrc2);
assign PCSrcD = (BranchD && EqualD);
assign RD1D = regin1;
assign RD2D = regin2;
assign RegisterRsD = InstructionD[25:21];
assign RegisterRtD = InstructionD[20:16]; 
assign RegisterRdD = InstructionD[15:11]; 
assign ShamtD = (ALUControlD == 9 ||ALUControlD == 11 || ALUControlD == 13) ? regin1:InstructionD[10:6];

endmodule
