module register(clk, rst, enable, regin, regout);

input clk, rst, enable;
input [31:0] regin;

output reg [31:0] regout;

always@(posedge clk) begin
    if (rst)  
        regout <= 32'b0;
    else if (enable)  
        regout <= regin;
end
endmodule