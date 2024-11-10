module program_counter #(parameter N=32)(input clk,input [N-1:0]pc_out,input [N-1:0]imm,
                                         input IFIDwrite,input equal,input [N-1:0]pc_hazard,output [N-1:0]pcout);

reg [N-1:0]pcoutbuff;
reg [N-1:0]pcoutbuff1;
reg [N-1:0]pcoutbuff2;
initial 
$display("Simulation started");

initial begin
pcoutbuff=32'b0;
pcoutbuff1=32'b0;
pcoutbuff2=32'b0;
end

always@(posedge clk)begin
   if(IFIDwrite)begin
      pcoutbuff<=pc_hazard;
   end else if(equal) begin
      pcoutbuff1<=pc_out+imm;
   end else begin
      pcoutbuff2<=pcoutbuff2+1;
   end
end
assign pcout=(IFIDwrite) ? pcoutbuff : (equal) ? pcoutbuff1 : pcoutbuff2;

endmodule