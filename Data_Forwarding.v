module Data_Forwarding #(parameter N=32)(input [4:0]EXMEMregrd,input [4:0]MEMWBregrd,
                                         input [1:0]WBin,input [1:0]WBin2,input [4:0]IDEXregr1,
                                         input [4:0]IDEXregr2,output [1:0]ForwardA,output [1:0]ForwardB);
/*Regwrite from WBin from EXMEM is used to check if forwarding is required or not as
there are some instructions which do not write back to the register*/  
/*Same for regwrite from WBin from MEMWB for forwarding*/                                   
reg [1:0]forAbuf;
reg [1:0]forBbuf;
always@(*)begin
  forAbuf=2'b00;
  forBbuf=2'b00;
if(WBin[0] && EXMEMregrd!=5'b0)begin
   if(EXMEMregrd==IDEXregr1)
     forAbuf=2'b10;
 else if(EXMEMregrd==IDEXregr2)
     forBbuf=2'b10;
 end
if(WBin2[0] && MEMWBregrd!=5'b0)begin
       if(!(WBin[0] && EXMEMregrd!=5'b0 && EXMEMregrd==IDEXregr1)&& MEMWBregrd==IDEXregr1)     
       /*Logic implemented to check if both EXMEM and MEMWB write to the same register,
         since EXMEM carries the most recent value, it is forwarded in the above case*/
          forAbuf=2'b01;
       else if(!(WBin[0] && EXMEMregrd!=5'b0 && EXMEMregrd==IDEXregr2) && MEMWBregrd==IDEXregr2)
          forBbuf=2'b01;
end 
end
        
assign ForwardA=forAbuf;
assign ForwardB=forBbuf;

endmodule