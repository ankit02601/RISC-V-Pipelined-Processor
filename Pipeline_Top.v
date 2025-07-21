module Pipeline_Top(clk,rst);

input clk,rst;

// declaration of wire
wire PCSrcE,RegWriteW,RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE,RegWriteM,MemWriteM,ResultSrcM,ResultSrcW;
wire [2:0] ALUControlE;
wire [4:0] RD_E,RDW,RD_M;


wire [31:0] PCTargetE,InstrD,PCD,PCPlus4D,ResultW,RD1_E,RD2_E,Imm_Ext_E,PCE,PCPlus4E,PCPlus4M,WriteDataM,ALU_ResultM,PCPlus4W,ALU_ResultW
,ReadDataW;
wire [4:0] RS1_E,RS2_E;
wire [1:0] ForwardAE,ForwardBE;
// declaration of module
Fetch_Cycle fetch(.clk(clk),.rst(rst),.PCSrcE(PCSrcE),
                   .PCTargetE(PCTargetE),.InstrD(InstrD),.PCD(PCD),.PCPlus4D(PCPlus4D)
                   );
                   
Decode_Cycle decode(.clk(clk),.rst(rst),.InstrD(InstrD),.PCD(PCD),
             .PCPlus4D(PCPlus4D),.RegWriteW(RegWriteW),.RDW(RDW),.ResultW(ResultW),
             .RegWriteE(RegWriteE),.ALUSrcE(ALUSrcE),.MemWriteE(MemWriteE),.ResultSrcE(ResultSrcE),
             .BranchE(BranchE),.ALUControlE(ALUControlE),.RD1_E(RD1_E) ,.RD2_E(RD2_E),
             .Imm_Ext_E(Imm_Ext_E),.RD_E(RD_E),.PCE(PCE),.PCPlus4E(PCPlus4E),.RS1_E(RS1_E),.RS2_E(RS2_E)
                 );                   
 Execute_Cycle execute(.clk(clk),.rst(rst),.RegWriteE(RegWriteE),.ALUSrcE(ALUSrcE),.MemWriteE(MemWriteE),
            .ResultSrcE(ResultSrcE),.BranchE(BranchE),.ALUControlE(ALUControlE),.RD1_E(RD1_E) ,.RD2_E(RD2_E)
                         ,.Imm_Ext_E(Imm_Ext_E),.RD_E(RD_E),.PCE(PCE),.PCPlus4E(PCPlus4E),
                         .PCTargetE(PCTargetE),.PCSrcE(PCSrcE),.RegWriteM(RegWriteM),
                         .MemWriteM(MemWriteM), .ResultSrcM(ResultSrcM),.RD_M(RD_M),.PCPlus4M(PCPlus4M),
                         .WriteDataM(WriteDataM),.ALU_ResultM(ALU_ResultM),
                         .ResultW(ResultW),.ForwardA_E(ForwardAE),.ForwardB_E(ForwardBE)
                         );  
                         
Memory_Cycle memory(.clk(clk),.rst(rst),.RegWriteM(RegWriteM),.MemWriteM(MemWriteM),
 .ResultSrcM(ResultSrcM),.RD_M(RD_M),.PCPlus4M(PCPlus4M),.WriteDataM(WriteDataM),.ALU_ResultM(ALU_ResultM),
.RegWriteW(RegWriteW),.ResultSrcW(ResultSrcW),.RD_W(RDW),.PCPlus4W(PCPlus4W),.ALU_ResultW(ALU_ResultW),.ReadDataW(ReadDataW)
);    

 WriteBack_Cycle wb(.clk(clk),.rst(rst),.ResultSrcW(ResultSrcW),.PCPlus4W(PCPlus4W),.ALU_ResultW(ALU_ResultW),
                         .ReadDataW(ReadDataW),.ResultW(ResultW)); 
                         
 Hazard_Unit forwarding_block(.rst(rst),.RegWriteM(RegWriteM),.RegWriteW(RegWriteW),.RD_M(RD_M),.RD_W(RDW),.Rs1_E(RS1_E),.Rs2_E(RS2_E),
 .ForwardAE(ForwardAE),.ForwardBE(ForwardBE));   
                                            
endmodule
