
module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);
input [6:0]Op,funct7;
input [2:0] funct3;
output RegWrite,MemWrite,ALUSrc,ResultSrc,Branch;
output[1:0] ImmSrc;
output[2:0] ALUControl;

wire [1:0]ALUOp;

main_decoder main_decoder(.op(Op),
                         .Branch(Branch),
                         .RegWrite(RegWrite),
                         .MemWrite(MemWrite),
                         .ImmSrc(ImmSrc),
                         .ResultSrc(ResultSrc),
                         .ALUSrc(ALUSrc),
                         .ALUOp(ALUOp)
                         
);
ALU_decoder ALU_decoder(.ALUOp(ALUOp),
                        .op(Op[5]),
                        .funct3(funct3),
                        .funct7(funct7),
                        .ALUControl(ALUControl)
);

   
endmodule
