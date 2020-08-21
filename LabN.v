//Course: EECS2021
//yChipE is a modified yChip with added outputs for testing/display
module yChipE(ins, z, PC, wb, entryPoint, INT, clk, rd1,rd2,imm,isRtype,isbranch,zero);
output [31:0] rd1,rd2,imm;
output isRtype,isbranch,zero;
output [31:0] ins, z, PC, wb;
input [31:0] entryPoint;
input INT, clk;
wire [2:0] op;
wire [31:0] jTarget;
wire [31:0] branch;
wire [6:0] opCode;
wire zero, isbranch, isjump, isStype, isRtype, isItype, isLw;
wire RegWrite, ALUSrc, Mem2Reg, MemRead, MemWrite;
wire [2:0] funct3;
wire [1:0] ALUop;
wire [31:0] wd, rd1, rd2, imm, PCp4, z, memOut, PCin;
yIF myIF(ins, PC, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;
yPC myPC(PCin, PC, PCp4, INT, entryPoint, branch, jTarget, zero, isbranch, isjump);
assign opCode = ins[6:0];
assign funct3 = ins[14:12];
yC1 myC1(isStype, isRtype, isItype, isLw, isjump, isbranch,opCode);
yC2 myC2(RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, isStype, isRtype, isItype,
isLw, isjump, isbranch);
yC3 myC3(ALUop, isRtype, isbranch);
yC4 myC4(op, ALUop, funct3);
endmodule
//yChipE testing
module t_yChipE;
reg [31:0] entryPoint;
reg clk, INT;
wire [31:0] ins, wb, PC, z;
wire [31:0] rd1,rd2,imm;
wire isRtype,isbranch,zero;
yChipE myChip(ins, z, PC, wb, entryPoint, INT, clk,
rd1,rd2,imm,isRtype,isbranch,zero); //kk
initial
begin
//‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐Entry point
entryPoint = 32'h28; INT = 1; #1;
//‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐Run program
repeat (43) begin
//‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐Fetch an ins
clk = 1; #1; INT = 0;
//‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐Execute the ins
clk = 0; #1;
//‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐‐Show results
if (isRtype) $display("PC:%h ins:%h R rs1:%h rs2:%h
rd_:%h",PC,ins,rd1,rd2,wb);
if (isbranch) $display("PC:%h ins:%h B rs1:%h rs2:%h imm:%h
zero:%b",PC,ins,rd1,rd2,PC+imm*2,zero);
end
$finish;
end
endmodule