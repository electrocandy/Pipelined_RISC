module EX_MEM #(parameter N=32)(input clk,input [2:0]MEM_in,input [1:0]WB_in,
               input [N-1:0]Aluout,input [4:0]loadreg,input [N-1:0]branchsum,
               input zero,input [N-1:0]reg2,output [2:0]MEM_out,
               output [1:0]WB_out,output zero1,output [N-1:0]Writedata,
               output [N-1:0]Alu,output [4:0]loadregout,output [N-1:0]branchout);

reg [2:0]membuf;
reg [1:0]wbbuf;
reg [N-1:0]Alubuf;
reg zerobuf;
reg [4:0]loadbuf;
reg [N-1:0]reg2buf;
reg [N-1:0]branchbuf;             
always@(posedge clk)begin
membuf<=MEM_in;
wbbuf<=WB_in;
Alubuf<=Aluout;
zerobuf<=zero;
loadbuf<=loadreg;
reg2buf<=reg2;
branchbuf<=branchsum;
end

assign MEM_out=membuf;
assign WB_out=wbbuf;
assign zero1=zerobuf;
assign Writedata=reg2buf;
assign loadregout=loadbuf;
assign Alu=Alubuf;
assign branchout=branchbuf;

endmodule