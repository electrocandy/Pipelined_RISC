module ID_EX #(parameter N=32)(input clk,input pc,input [2:0]EX_in,input [2:0]MEM_in,
             input [1:0]WB_in,input [4:0]register1,input [4:0]register2,
             input [4:0]loadreg,input [N-1:0]immgenout,input [3:0]Alucon,
             output [4:0]outreg1,output [4:0]outreg2,output [3:0]AluConin,
             output [4:0]Loadregout,output [2:0]EX_out,output [2:0]MEM_out,
             output [1:0]WB_out,output pc_out,output [N-1:0]imm);
/*The Control outputs are divided into three categories EX,MEM,WB to pass on the values 
to the respective stages from this pipeline register as these values change on 
every clock cycle*/
/*(In order 2,1,0)
EX- Aluop,Alusrc
MEM- memread,memwrite,branch
WB- memtoreg,regwrite
*/
reg pcbuf;
reg [2:0]exbuf;
reg[2:0]membuf;
reg[1:0]wbbuf;
reg [4:0]reg1buf;
reg [4:0]reg2buf;
reg [N-1:0]immbuf;
reg [4:0]loadbuf;
reg [3:0]Alu;
always@(posedge clk) begin
pcbuf<=pc;
exbuf<=EX_in;
membuf<=MEM_in;
wbbuf<=WB_in;
reg1buf<=register1;
reg2buf<=register2;
immbuf<=immgenout;
Alu<=Alucon;
loadbuf<=loadreg;
end

assign pc_out=pcbuf;
assign EX_out=exbuf;
assign MEM_out=membuf;
assign WB_out=wbbuf;
assign outreg1=reg1buf;
assign outreg2=reg2buf;
assign imm=immbuf;
assign Aluconin=Alu;
assign loadregout=loadbuf;

endmodule