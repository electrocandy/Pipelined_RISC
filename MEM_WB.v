module MEM_WB #(parameter N=32)(input clk,input [1:0]WB_in,input [4:0]loadreg,
                               input [N-1:0]readdata,input [N-1:0]Aluresult,
                               output [N-1:0]dataout,output [N-1:0]Aluresout,
                               output [4:0]loadout,output [1:0]WB_out);
reg [N-1:0]databuf;
reg [N-1:0]Alubuf;
reg [4:0]loadbuf;
reg [1:0]wbbuf;
always@(posedge clk)begin
databuf<=readdata;
Alubuf<=Aluresult;
loadbuf<=loadreg;
wbbuf<=WB_in;
end 

assign dataout=databuf;
assign Aluresout=Alubuf;
assign loadout=loadbuf;
assign WB_out=wbbuf;
                              
endmodule                               