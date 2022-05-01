`include "config.v"

module ControlUnit(Op, Funct, RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUControlD, ALUSrcD, RegDstD, JumpD, JalD, JrD, IsShiftD);
input [5:0] Op, Funct;
output reg RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD, RegDstD, JumpD, JalD, JrD, IsShiftD;
output reg [4:0] ALUControlD;
always @(*) begin
        case(Op) 
        6'h00: begin
        RegDstD   = 1'b1;
        RegWriteD = 1'b1;
        MemtoRegD = 1'b0;
        MemWriteD = 1'b0;
        BranchD   = 1'b0;
        ALUSrcD   = 1'b0;
        JumpD     = 1'b0;
        JalD      = 1'b0;
        JrD       = 1'b0;      
        IsShiftD = 0;  
            case(Funct)
                6'h20: begin ALUControlD = `ALUctr_ADD ;end // Add
                6'h21: begin ALUControlD = `ALUctr_ADDU;end // Addu
                6'h22: begin ALUControlD = `ALUctr_SUB ;end // Sub
                6'h23: begin ALUControlD = `ALUctr_SUBU;end // Subu
                6'h24: begin ALUControlD = `ALUctr_AND ;end // and
                6'h25: begin ALUControlD = `ALUctr_OR  ;end // or
                6'h26: begin ALUControlD = `ALUctr_XOR ;end // xor
                6'h27: begin ALUControlD = `ALUctr_NOR ;end // nor
                6'h00: begin ALUControlD = `ALUctr_SLL ; IsShiftD = 1'b1; end // sll
                6'h02: begin ALUControlD = `ALUctr_SRL ; IsShiftD = 1'b1; end // srl
                6'h03: begin ALUControlD = `ALUctr_SRA ; IsShiftD = 1'b1; end // sra
                6'h04: begin ALUControlD = `ALUctr_SLLV; IsShiftD = 1'b1; end // sllv
                6'h06: begin ALUControlD = `ALUctr_SRLV; IsShiftD = 1'b1; end // srlv
                6'h07: begin ALUControlD = `ALUctr_SRAV; IsShiftD = 1'b1; end // srav
                6'h2A: begin ALUControlD = `ALUctr_SLT ;end // slt
                6'h08: begin
                            ALUControlD = `ALUctr_JR ;
                            RegDstD   = 1'b0;
                            RegWriteD = 1'b1;
                            MemtoRegD = 1'b0;
                            MemWriteD = 1'b0;
                            BranchD   = 1'b0;
                            ALUSrcD   = 1'b1;
                            JumpD     = 1'b0;
                            JalD      = 1'b0;
                            JrD       = 1'b1;
                        end // jr
                6'h00: begin
                            ALUControlD = 0;
                            RegDstD   = 1'b0;
                            RegWriteD = 1'b0;
                            MemtoRegD = 1'b0;
                            MemWriteD = 1'b0;
                            BranchD   = 1'b0;
                            ALUSrcD   = 1'b0;
                            JumpD     = 1'b0;
                            JalD      = 1'b0;
                            JrD       = 1'b0;
                            IsShiftD = 0;
                end
            endcase
        end
        6'h08: begin 
            ALUControlD = `ALUctr_ADDI ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            JrD       = 1'b0;
            IsShiftD = 0;
        end // addi
        6'h09: begin 
            ALUControlD = `ALUctr_ADDIU;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            JrD       = 1'b0;
            IsShiftD = 0;
        end // addiu
        6'h0C: begin 
            ALUControlD = `ALUctr_ANDI ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // andi
        6'h04: begin 
            ALUControlD = `ALUctr_BEQ  ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b0;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b1;
            ALUSrcD   = 1'b0;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // beq
        6'h05: begin 
            ALUControlD = `ALUctr_BNE  ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b0;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b1;
            ALUSrcD   = 1'b0;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // bne
        6'h23: begin 
            ALUControlD = `ALUctr_LW   ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b1;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // lw
        6'h2B: begin 
            ALUControlD = `ALUctr_SW   ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b0;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b1;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // sw
        6'h0D: begin 
            ALUControlD = `ALUctr_ORI  ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // ori
        6'h0E: begin 
            ALUControlD = `ALUctr_XORI ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b0;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // xori
        6'h02: begin
            ALUControlD = `ALUctr_J ;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b1;
            JumpD     = 1'b1;
            JalD      = 1'b0;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // j
        6'h03: begin
            ALUControlD = `ALUctr_JAL;
            RegDstD   = 1'b0;
            RegWriteD = 1'b1;
            MemtoRegD = 1'b0;
            MemWriteD = 1'b0;
            BranchD   = 1'b0;
            ALUSrcD   = 1'b0;
            JumpD     = 1'b0;
            JalD      = 1'b1;
            IsShiftD = 0;
            JrD       = 1'b0;
        end // jal
        endcase
    end

endmodule