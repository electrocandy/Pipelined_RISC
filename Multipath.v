module Multipath #(parameter N=32)(input clk);

wire branch,zero,IFIDwrite,flush,Select;
wire [6:0]z;
wire [N-1:0]instruction,[N-1:0]pcout,[N-1:0]imm,[N-1:0]instruction_Hazard,[N-1:0]pc_hazard,[N-1:0]instruction_out,
     [N-1:0]pc_out,[2:0]MEM_out,[4:0]EXMEMregrd,[N-1:0]pc,[N-1:0]instruction_out1,[N-1:0]data_frommux,[N-1:0]data1,[N-1:0]data2,
     [2:0]MEM_in,[2:0]EX_in,[1:0]WB_in,[4:0]outreg1,[4:0]outreg2,[4:0]Loadregout,[2:0]EX_out,[2:0]MEM_out,[1:0]WB_out,[N-1:0]imm_out
     [3:0]Alucon,[N-1:0]Alu_data,[N-1:0]dt1,[N-1:0]dt2,[N-1:0]Alu,[1:0]ForwardA,[1:0]ForwardB,[N-1:0]muxAout,[N-1:0]muxBout,
     [2:0]MEM_out_EXMEM,[1:0]WB_out_EXMEM,[N-1:0]Writedata,[N-1:0]mem_in,[N-1:0]mem_out,[N-1:0]data_out,[N-1:0]Aluresout,[1:0]WB_out_MEMWB,
     [4:0]Loadregout_out,[4:0]Loadregout_out_out,[6:0]muxCout;


program_counter ins1(branch,zero,imm,clk,pcout);
instruction_memory ins2(pcout,clk,instruction);
IF_ID ins3(clk,pcout,flush,instruction,IFIDwrite,instruction_Hazard,pc_hazard,instruction_out,pc_out);
Hazard_unit ins4(clk,MEM_out,Loadregout,instruction_out,pc_out,pc,instruction_out1,IFIDwrite,Select);
register ins5(instruction_out[19:15],instruction_out[24:20],data_frommux,clk,instruction_out[11:7],WB_out_MEMWB[0],data1,data2);
immediategenerate ins6(instruction_out,imm);
control ins7(instruction_out[6:0],clk,MEM_in[0],MEM_in[2],WB_in[1],EX_in[2:1],MEM_in[1],EX_in[0],WB_in[0]);
mux21 #(.N(7)) insC({EX_in,MEM_in,WB_in},0,Select,muxCout);
ID_EX ins8(clk,muxCout[6:5],muxCout[4:2],muxCout[1:0],instruction_out[19:15],instruction_out[24:20],instruction_out[11:7],imm,instruction_out,
           data1,data2,outreg1,outreg2,Loadregout,EX_out,MEM_out,WB_out,imm_out,instruc_out,dt1,dt2);
ALUControl ins9(EX_out[2:1],instruc_out[14:12],instruc_out[30],Alucon);
mux31 insA(dt1,data_frommux,Alu/*From EX_MEM pipe*/,ForwardA,muxAout);
mux31 insB(dt2,data_frommux,Alu/*From EX_MEM pipe*/,ForwardB,muxBout);
ALU ins10(muxAout,muxBout,Alucon,Alu_data);
Data_Forwarding ins11(Loadregout_out,Loadregout_out_out,WB_out_EXMEM,WB_out_MEMWB,outreg1,outreg2,ForwardA,ForwardB);
EX_MEM ins12(clk,MEM_in,WB_in,Alu_data,Loadregout,muxBout,MEM_out_EXMEM,WB_out_EXMEM,Writedata,mem_in,Loadregout_out);
data_memory ins13(mem_in,Writedata,clk,MEM_out_EXMEM[2],MEM_out_EXMEM[1],mem_out);
MEM_WB ins14(clk,WB_out_EXMEM,Loadregout_out,mem_out,mem_in,data_out,Aluresout,Loadregout_out_out,WB_out_MEMWB);
mux21 ins15(data_out,Aluresout,WB_out_MEMWB[1],data_frommux);

endmodule