module Hazard_unit #(parameter N=32)(input clk,input [2:0]IDEX_MEM,input [4:0]EXMEMregrd,input [N-1:0]instruction,input [N-1:0]pc_in,
                                     output [N-1:0]pc,output [N-1:0]instruction_out, output IFIDwrite);

reg [4:0]r1;
reg [4:0]r2;
reg [N-1:0]pcbuf;
reg [N-1:0]instructionbuf;
reg ifidwritebuf;

initial begin
   ifidwritebuf=1'b0; 
end

always@(posedge clk)begin
    r1=instruction[19:15]; /*R-type Instruction*/
    r2=instruction[24:20];
    if(IDEX_MEM[0])begin
        if(EXMEMregrd==r1 || EXMEMregrd==r2)begin
          pcbuf<=pc_in;
          instructionbuf<=instruction;
          ifidwritebuf<=1'b1;
        end
    end
end

assign instruction_out=instructionbuf;
assign pc_out=pc_in;
assign IFIDwrite=ifidwritebuf;

endmodule
          
