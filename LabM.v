
//
// Lab Test M
// EECS 2021
// This module tests the cpu. The instructions are in ram.dat.
module labM;
reg [31:0] PCin;
reg RegWrite, clk, ALUSrc, MemRead, MemWrite, Mem2Reg;
reg[2:0] op;
reg add, sw;
wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, branch, memOut, wb;
wire signed [31:0] jTarget;
wire [1:0] zero;
yIF myIF(ins, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;
initial begin
PCin = 16'h28;
repeat (11) begin
clk = 1; #1;
add = 0;
sw = 0;
op = 3'b010;
if (ins[6:0] == 7'h33) begin
// R‐type
RegWrite = 1;
ALUSrc = 0;
MemRead = 0;
MemWrite = 0;
Mem2Reg = 0;
if (ins[14:12] == 3'b110) begin
op = 3'b001;
end
else begin
add = 1;
end
end
else if (ins[6:0] == 7'h3) begin
// I‐type ld
RegWrite = 1;
ALUSrc = 1;
MemRead = 1;
MemWrite = 0;
Mem2Reg = 1;
end
else if (ins[6:0] == 7'h13) begin
// I‐type addi
RegWrite = 1;
ALUSrc = 1;
MemRead = 0;
MemWrite =0;
Mem2Reg = 0;
end
else if (ins[6:0] == 7'h23) begin

// S‐type
RegWrite = 0;
ALUSrc = 1;
MemRead = 0;
MemWrite = 1;
Mem2Reg = 0;
sw = 1;
end
else if (ins[6:0] == 7'h63) begin
//SB‐type
RegWrite = 0;
ALUSrc = 0;
MemRead = 0;
MemWrite = 0;
Mem2Reg = 0;
end
else if (ins[6:0] == 7'h6F) begin
// UJ‐type
RegWrite = 1;
ALUSrc = 1;
MemRead = 0;
MemWrite = 0;
Mem2Reg = 0;
end
else begin
$display("***INVALID INSTRUCTION***\t%h", ins[31:0]);
end
clk = 0; #1;
if (add) begin
$display("PC: %h add: rs1:%h rs2:%h rd :%h", PCin, rd1, rd2, z);
end
if (sw) begin
$display("PC: %h sw : rs1:%h rs2:%h imm:%h", PCin, rd1, rd2, wb);
end
PCin = PCp4;
end
$finish;
end
endmodule