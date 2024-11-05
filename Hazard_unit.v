module Hazard_unit #(parameter N=32)(input clk,input [2:0]IDEX_MEM,input [4:0]IDEXregrd,input [N-1:0]instruction,
                                     output [N-1:0]instruction_out, output IFIDwrite,output Select);
/*Check if pc is required in hazard unit, if required add it*/

reg [4:0]r1;
reg [4:0]r2;
reg [N-1:0]instructionbuf;
reg ifidwritebuf;
reg Selectbuf;

initial begin
   ifidwritebuf=1'b0;
   Selectbuf=1'b1;
end

always@(posedge clk)begin
    r1=instruction[19:15]; /*R-type Instruction*/
    r2=instruction[24:20];
    if(IDEX_MEM[2])begin
        if(IDEXregrd==r1 || IDEXregrd==r2)begin
          instructionbuf<=instruction;
          ifidwritebuf<=1'b1;
          Selectbuf<=1'b0;
        end
    end
end

assign instruction_out=instructionbuf;
assign IFIDwrite=ifidwritebuf;
assign Select=Selectbuf;

endmodule
          
