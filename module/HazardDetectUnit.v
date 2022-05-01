module HazardDetect(
    MemtoRegE,
    MemtoRegM,
    BranchD,
    JumpD,
    JalD,
    JrD,
    PCSrcD,
    RegisterRtE,
    RegisterRsD,
    RegisterRtD,
    WriteRegE,
    WriteRegM,
    RegWriteE,
    ishazard,
    IFflush
);

input MemtoRegE, MemtoRegM, BranchD, PCSrcD, JalD, JrD, JumpD, RegWriteE;
input [4:0] RegisterRtE, RegisterRsD, RegisterRtD, WriteRegE, WriteRegM;

output ishazard, IFflush;


assign ishazard = (MemtoRegE && ((WriteRegE == RegisterRsD) || (WriteRegE == RegisterRtD))) || // lw stall
               (RegWriteE && BranchD && ((RegisterRsD == WriteRegE) || (RegisterRtD == WriteRegE))) || // comparison register is the desitination of preceding alu insruction.
               (MemtoRegM && BranchD && ((RegisterRsD == WriteRegM) || (RegisterRtD == WriteRegM))) || // comparison register is the desitination of 2nd preceding lw instruction.
               (RegWriteE && JrD && ((RegisterRsD == WriteRegE) || (RegisterRtD == WriteRegE))) || // JR instruction following an alu instruction.
               (MemtoRegM && JrD && ((RegisterRsD == WriteRegM) || (RegisterRtD == WriteRegM))); // JR register is the desitination of 2nd preceding lw instruction.

assign IFflush = PCSrcD || JumpD || JalD || JrD;

endmodule