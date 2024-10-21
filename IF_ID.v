module IF_ID #(parameter N=32)(input clk,input pc_in,input flush,input [N-1:0]instruction_in,
             output [N-1:0]instruction_out,output pc_out);
reg [N-1:0]instructionbuf;
reg [N-1:0]pcbuf;             

always@(posedge clk)
begin
if(flush) begin
   pcbuf<=32'b0;
   instructionbuf<=32'b0;
end else begin
   pcbuf<=pc_in;
   instructionbuf<=instruction_in;
end
end

assign instruction_out=instructionbuf;
assign pc_out=pcbuf;
endmodule