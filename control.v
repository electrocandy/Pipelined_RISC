module control #(parameter N=32)
(input [6:0]instr,input clk,output branch,output memread,output memtoreg,output [1:0]ALUop,output memwrite,output ALUsrc,output regwrite);

reg [7:0] out;
always@(*)begin
case(instr[6:0])
7'b0110011: out=8'b00010001; //R-type //Here both memreg and memread are zero as memory is used only during load or store operations
7'b0000011: out=8'b01100011; //I-type
7'b0100011: out=8'b00x00110; //S-type
7'b1100011: out=8'b10x01000; //B_type(BEQ)
//Since regwrite is 0 for store and beq instructions, the memtoreg is declared as dont care(x) as the register is not being written
default: out=8'bx;
endcase
end

assign {branch,memread,memtoreg,ALUop,memwrite,ALUsrc,regwrite}=out; 

endmodule