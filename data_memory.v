module data_memory #(parameter N=32,parameter M=256)
(input [N-1:0]address,input [N-1:0]data_input,input clk,input memread,input memwrite,output [N-1:0]data);

//data memory needs memread signal as reading invalid address causes issues

reg [N-1:0] mem[M-1:0];
reg [N-1:0] databuf=0;
integer i;
initial begin
for(i=0;i<M;i=i+1)
   mem[i]=32'b1;
end

always@(posedge clk) begin
if(memwrite) //memory write is performed always at clock edge in data memory
  mem[address]=data_input;
end

always@(*) begin
if(memread)  //memory read is performed for any change in sensitivity list(inputs)
  databuf=mem[address];
end

assign data=databuf;

endmodule