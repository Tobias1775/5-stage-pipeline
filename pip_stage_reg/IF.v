
module IF (clk, rst, PCBranchD, PCSrcD, JumpD, JalD, JrD, stall, JumpAddr, PCPlus4Fin, PCPlus4Fout, instruction);

input clk, rst, stall, JumpD, JalD, JrD, PCSrcD;

input [31:0] PCBranchD, PCPlus4Fin, JumpAddr;

output [31:0] PCPlus4Fout, instruction;

wire [31:0] PC, PCmid, PCF;

// Select whether the branch address or PC+4.
mux2to1 Branchmux(
    .in1(PCPlus4Fin),
    .in2(PCBranchD),
    .sel(PCSrcD),
    .out(PCmid)
);

// Select whether the address is the jump address. 
mux2to1 Jumpmux(
    .in1(PCmid),
    .in2(JumpAddr),
    .sel(JumpD || JalD || JrD),
    .out(PC)
);

register PCreg(
    .clk(clk),
    .rst(rst),
    .enable(~stall),
    .regin(PC),
    .regout(PCF)
);

adder plus4(
    .in1(32'd4),
    .in2(PCF),
    .out(PCPlus4Fout)
);
// Fetch the instruction.
InstructionRAM instructions(
    .RESET(rst),
    .ENABLE(~stall),
    .FETCH_ADDRESS(PCF),
    .DATA(instruction)
);

endmodule