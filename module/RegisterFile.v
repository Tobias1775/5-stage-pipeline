module Regfile(clk, rst, WriteEn, Src1, Src2, WriteReg, WriteData, regout1, regout2);

input clk, rst, WriteEn;
input [4:0] WriteReg, Src1, Src2;
input [31:0] WriteData;
output [31:0] regout1, regout2;

reg [31:0] regfilemem [0:31];
integer i;

always@(negedge clk) begin
    if (rst) begin
        for (i = 0; i < 32; i = i + 1)
            regfilemem[i] <= 0;
    end
    else if (WriteEn) begin
        regfilemem[WriteReg] <= WriteData;
    end
end

assign regout1 = regfilemem[Src1];
assign regout2 = regfilemem[Src2];

endmodule