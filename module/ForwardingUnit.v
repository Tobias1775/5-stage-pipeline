module ForwardingUnit(
    RegisterRsD,
    RegisterRtD,
    RegisterRsE,
    RegisterRtE,
    WriteRegE,
    WriteRegM,
    WriteRegW,
    BranchD,
    JrD,
    RegWriteM,
    RegWriteW,
    ForwardA,
    ForwardB,
    ForwardC,
    ForwardD
);

input RegWriteM, RegWriteW, BranchD, JrD;
input [4:0] RegisterRsD, RegisterRtD, RegisterRsE, RegisterRtE, WriteRegE, WriteRegM, WriteRegW;

output reg [1:0] ForwardA, ForwardB;
output reg ForwardC, ForwardD;

always @(*) begin
    ForwardA = 2'b00;
    ForwardB = 2'b00;
    ForwardC = 1'b0;
    ForwardD = 1'b0;
    // EX hazard
    if (RegWriteM && (WriteRegM != 0) && (WriteRegM == RegisterRsE)) begin ForwardA = 2'b10;end // Rs hazard
    else if (RegWriteM && (WriteRegM != 0) && (WriteRegM == RegisterRtE)) begin ForwardB = 2'b10;end // Rt hazard
    // MEM hazard
    if (RegWriteW && (WriteRegW != 0) && (WriteRegW == RegisterRsE)) begin ForwardA = 2'b01;end
    else if (RegWriteW && (WriteRegW != 0) && (WriteRegW == RegisterRtE)) begin ForwardB = 2'b01;end
    // Branch and Jump Hazard.
    if (BranchD && (RegWriteM!= 0) && (WriteRegW != 0) && (WriteRegM == RegisterRsD)) begin ForwardC = 1; end
    if (BranchD && (RegWriteM!= 0) && (WriteRegW != 0) &&(WriteRegM == RegisterRtD)) begin ForwardD = 1; end
    if (JrD && (RegWriteM!= 0) && (WriteRegW != 0) &&(WriteRegM == RegisterRsD)) begin ForwardC = 1; end

    
end 
endmodule