`include "config.v"
module ALU (
    SrcA,
    SrcB,
    ALUControl,
    ALUOut,
    Zero
);

input [31:0] SrcA, SrcB;
input [4:0] ALUControl;

output reg [31:0] ALUOut;
output reg Zero;

always @(*) begin
    case (ALUControl)
    `ALUctr_ADD: begin ALUOut = $signed(SrcA) + $signed(SrcB); Zero = 0; end
    `ALUctr_ADDU: begin ALUOut = SrcA + SrcB; Zero = 0; end 
    `ALUctr_SUB: begin ALUOut = $signed(SrcA) - $signed(SrcB); Zero = (ALUOut == 0); end 
    `ALUctr_SUBU: begin ALUOut = SrcA - SrcB; Zero = 0; end 
    `ALUctr_AND: begin ALUOut = SrcA & SrcB; Zero = 0; end 
    `ALUctr_OR: begin ALUOut = SrcA | SrcB; Zero = 0; end 
    `ALUctr_XOR: begin ALUOut = SrcA ^ SrcB; Zero = 0; end 
    `ALUctr_NOR: begin ALUOut = ~(SrcA | SrcB); Zero = 0; end 
    `ALUctr_SLL: begin ALUOut = SrcB << SrcA; Zero = 0; end
    `ALUctr_SLLV: begin ALUOut = SrcB << SrcA; Zero = 0; end
    `ALUctr_SRA: begin ALUOut = $signed(SrcB) >>> $signed(SrcA); Zero = 0; end
    `ALUctr_SRAV: begin ALUOut = $signed(SrcB) >>> $signed(SrcA); Zero = 0; end
    `ALUctr_SRL: begin ALUOut = SrcB >> SrcA; Zero = 0; end
    `ALUctr_SRLV: begin ALUOut = SrcB >> SrcA; Zero = 0; end
    `ALUctr_SLT: begin ALUOut = SrcA < SrcB; Zero = 0; end
    `ALUctr_ADDI: begin ALUOut = SrcA + SrcB; Zero = 0; end
    `ALUctr_ADDIU: begin ALUOut = SrcA + SrcB; Zero = 0; end
    `ALUctr_ANDI: begin ALUOut = SrcA & {{16'b0},SrcB[15:0]}; Zero = 0; end
    `ALUctr_ORI: begin ALUOut = SrcA | {{16'b0},SrcB[15:0]}; Zero = 0; end
    `ALUctr_XORI: begin ALUOut = SrcA ^ {{16'b0},SrcB[15:0]}; Zero = 0; end
    `ALUctr_BEQ: begin ALUOut = SrcA - SrcB; Zero = (SrcA - SrcB == 0); end
    `ALUctr_BNE: begin ALUOut = SrcA - SrcB; Zero = (SrcA - SrcB != 0); end
    `ALUctr_LW: begin ALUOut = SrcA + SrcB; Zero = 0; end
    `ALUctr_SW: begin ALUOut = SrcA + SrcB; Zero = 0; end
    `ALUctr_J: begin ALUOut = 0; Zero = 0; end
    `ALUctr_JR: begin ALUOut = 0; Zero = 0; end
    `ALUctr_JAL: begin ALUOut = SrcB; Zero = 0; end
    endcase
end
endmodule