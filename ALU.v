
module ALU(
input [31:0] A,B,
input [2:0]ALUControl,
output [31:0] Result,
output Z,N,C,V
    );
    
  
    wire[31:0] Sum;
    wire cout;
    wire [31:0] slt;
    
    assign Sum = (ALUControl[0] == 1'b0)? A+B:(A +((~B)+1));
                                         
    assign {cout ,Result} = (ALUControl==3'b000)?Sum:
                            (ALUControl==3'b001)?Sum:
                            (ALUControl==3'b010)?A &B:
                            (ALUControl==3'b011)?A |B:
                            (ALUControl==3'b101) ? {{32{1'b0}},(Sum[31])} :{33{1'b0}};
 
    assign slt= {31'b0 ,Sum[31]};
    
  
    
    // Flag assignment
    assign Z=&(~Result); // Zero flag
    assign N=Result[31];// negative flag N=1 
    assign C= cout & (~ALUControl[1]);
    assign V= (~ALUControl[1]) &(Sum[31]^A[31])&(~(A[31]^B[31]^ALUControl[0]));
    
endmodule
