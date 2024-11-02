module Multipath #(parameter N=32)(input clk);

wire branch,zero;
wire [N-1:0]instruction,[N-1:0]pcout,[N-1:0]imm,flush,IFIDwrite,[N-1:0]instruction_Hazard,[N-1:0]pc_hazard,[N-1:0]instruction_out,
     [N-1:0]pc_out,[2:0]MEM_out,[4:0]EXMEMregrd;


program_counter ins1(branch,zero,imm,clk,pcout);
instruction_memory ins2(pcout,clk,instruction);
IF_ID ins3(clk,pcout,flush,instruction,IFIDwrite,instruction_Hazard,pc_hazard,instruction_out,pc_out);
Hazard_unit ins4(clk,MEM_out,EXMEMregrd);
register ins5();
immediategenerate ins6();
control ins7();
ID_EX ins8();
AluControl ins9();
ALU ins10();
Data_Forwarding ins11();
EX_MEM ins12();
data_memory ins13();
MEM_WB ins14();

endmodule