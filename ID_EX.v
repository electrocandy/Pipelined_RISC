module ID_EX #(parameter N=32)(input clk,input [2:0]EX_in,input [2:0]MEM_in,
             input [1:0]WB_in,input [4:0]register1,input [4:0]register2,
             input [4:0]loadreg,input [N-1:0]immgenout,input [N-1:0]instruction,
             input [N-1:0]regdata1,input [N-1:0]regdata2,
             output [4:0]outreg1,output [4:0]outreg2,
             output [4:0]Loadregout,output [2:0]EX_out,output [2:0]MEM_out,
             output [1:0]WB_out,output [N-1:0]imm,output [N-1:0]instruc_out,
             output [N-1:0]data1,output [N-1:0]data2);
/*The Control outputs are divided into three categories EX,MEM,WB to pass on the values 
to the respective stages from this pipeline register as these values change on 
every clock cycle*/
/*(In order 2,1,0)
EX- Aluop,Alusrc
MEM- memread,memwrite,branch
WB- memtoreg,regwrite
*/

reg [2:0]exbuf;
reg[2:0]membuf;
reg[1:0]wbbuf;
reg [4:0]reg1buf;
reg [4:0]reg2buf;
reg [N-1:0]immbuf;
reg [4:0]loadbuf;
reg [3:0]Alu;
reg [N-1:0]dt1;
reg [N-1:0]dt2;
always@(posedge clk) begin
exbuf<=EX_in;
membuf<=MEM_in;
wbbuf<=WB_in;
reg1buf<=register1;
reg2buf<=register2;
immbuf<=immgenout;
Alu<=Alucon;
loadbuf<=loadreg;
dt1<=regdata1;
dt2<=regdata2;
end

assign EX_out=exbuf;
assign MEM_out=membuf;
assign WB_out=wbbuf;
assign outreg1=reg1buf;
assign outreg2=reg2buf;
assign imm=immbuf;
assign Aluconin=Alu;
assign Loadregout=loadbuf;
assign data1=dt1;
assign data2=dt2;

endmodule