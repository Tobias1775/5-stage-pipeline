
module IFID (clk, rst, stallD, IFflush, PCPlus4F, InstructionF, PCPlus4D, InstructionD);

input clk, rst, stallD, IFflush;
input [31:0] PCPlus4F, InstructionF;
output reg [31:0] PCPlus4D, InstructionD;

always @(posedge clk) begin
    if (rst) begin
        PCPlus4D <= 0;
        InstructionD <= 0;
    end
    else if (~stallD) begin 
        if (IFflush) begin
            PCPlus4D <= 0;
            InstructionD <= 0;
        end
        else begin
            PCPlus4D <= PCPlus4F;
            InstructionD <= InstructionF;
        end
    end
end
endmodule
