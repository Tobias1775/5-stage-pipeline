module mux2to1(in1, in2, sel, out);

    input [31:0] in1, in2;
    input sel;
    output [31:0] out;

    assign out = (sel == 0)? in1:in2;

endmodule

module mux3to1(in1, in2, in3, sel, out);

    input [31:0] in1, in2, in3;
    input [1:0] sel;
    output [31:0] out;
    
    assign out = (sel == 2'd0) ? in1 : (sel==2'd1) ? in2 : in3;
endmodule 

module dstregmux2to1(in1, in2, sel, out);

    input [4:0] in1, in2;
    input sel;
    output [4:0] out;

    assign out = (sel == 0)? in1:in2;

endmodule

module dstregmux3to1(in1, in2, in3, sel, out);

    input [4:0] in1, in2, in3;
    input [1:0] sel;
    output [4:0] out;
    
    assign out = (sel == 2'd0) ? in1 : (sel==2'd1) ? in2 : in3;

endmodule
