module program_counter #(parameter N=32)(input clk,input [N-1:0]pc_in,input IFIDwrite,input [N-1:0]pc_hazard,output [N-1:0]pcout);

reg [N-1:0]pcoutbuff;
initial 
$display("Simulation started");

initial begin
pcoutbuff=32'b0;
end

always@(posedge clk)begin
   if(IFIDwrite)begin
      pcoutbuff<=pc_hazard;
   end else begin
      pcoutbuff<=pc_in;
   end
end
assign pcout=pcoutbuff;

endmodule