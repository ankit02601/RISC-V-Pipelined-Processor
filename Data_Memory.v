
module Data_Memory(A,WD,clk,WE,RD);

input clk,WE;
input [31:0]A,WD;

output [31:0]RD;

reg [31:0] Data_Mem[1023:0];

always @(posedge clk)
begin
if(WE)
Data_Mem[A]<= WD;
end
// read
assign RD= (WE==1'b0)? Data_Mem[A]:32'h00000000;



initial begin
Data_Mem[28]=32'h00000020;
Data_Mem[40]=32'h00000002;
end

    
endmodule
