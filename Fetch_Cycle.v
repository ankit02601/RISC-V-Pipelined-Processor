
module Fetch_Cycle(clk,rst,PCSrcE,PCTargetE,InstrD,PCD,PCPlus4D);
input clk,rst;
input PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD;
output [31:0] PCD,PCPlus4D;

//Declaration of registers
reg [31:0] InstrF_reg;
reg[31:0] PCF_reg,PCPlus4F_reg;
//Declaring Interim Wires
wire [31:0] PC_F,PCF,PCPlus4F;
wire [31:0] InstrF;
//Initiation modules
// Declare PC_mux
Mux PC_mux(
           .a(PCPlus4F),
           .b(PCTargetE),
           .s(PCSrcE),
           .c(PC_F)
           );    
// Declare Pc counter
P_C Program_counter(
                    .PC_NEXT(PC_F),
                    .PC(PCF),
                    .rst(rst),
                    .clk(clk)
                    );  
Instr_Mem IMEM(
               .A(PCF),
               .rst(rst),
               .RD(InstrF)
               ) ;    
               
PC_adder PC_adder(
                  .a(PCF),
                  .b(32'h00000004),
                  .c(PCPlus4F)
                  );  
 //Fetch Cycle Register logic                 
 always@(posedge clk or negedge rst) 
 begin
 if(rst==1'b0)begin
 InstrF_reg<=32'h00000000;
 PCF_reg<=32'h00000000;
 PCPlus4F_reg<=32'h00000000;
 end
 else begin
 InstrF_reg<=InstrF;
 PCF_reg<=PCF;
 PCPlus4F_reg<=PCPlus4F;
 end
 end
 
 //Assigning register value to the output ports
 
 assign InstrD = (rst==1'b0)? 32'h00000000:InstrF_reg; 
 assign PCD = (rst==1'b0)? 32'h00000000:PCF_reg;
 assign PCPlus4D = (rst==1'b0)? 32'h00000000:PCPlus4F_reg;                                                    
endmodule
