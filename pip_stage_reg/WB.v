module WB(
    MemtoRegW,
    ALUOutW,
    ReadDataW,
    ResultW
);

input MemtoRegW;
input [31:0] ALUOutW, ReadDataW;
output [31:0] ResultW;

mux2to1 resultmux(
    .in1(ALUOutW),
    .in2(ReadDataW),
    .sel(MemtoRegW),
    .out(ResultW)
);

endmodule