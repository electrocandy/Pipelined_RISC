module Multipath #(parameter N=32)(input clk);

wire IFIDwrite, flush, Select, equal;
wire [N-1:0] instruction, pcout, imm, instruction_out, pc_out, pc, 
             data_frommux, data1, data2, imm_out, Alu_data, dt1, dt2, Alu, 
             muxAout, muxBout, Writedata, mem_in, mem_out, data_out, Aluresout, 
             muxDin1, muxDin2, muxDout,instruc_out;
             
wire [2:0] MEM_out, MEM_in, EX_in, EX_out, MEM_out_EXMEM;
wire [1:0] WB_in, WB_out, WB_out_EXMEM, WB_out_MEMWB, ForwardA, ForwardB;
wire [4:0] outreg1, outreg2, Loadregout, Loadregout_out, Loadregout_out_out;
wire [3:0] Alucon;
wire [7:0] muxCout;
wire [7:0] con,zero;

assign zero=8'b0;

mux21 insD(muxDin1,muxDin2,equal,muxDout);
program_counter ins1(clk,muxDout,IFIDwrite,pc,pcout);
nbitadder ins16(pcout,1,muxDin1);
instruction_memory ins2(pcout,clk,instruction);
IF_ID ins3(clk,pcout,flush,instruction,IFIDwrite,/*instruction_Hazard,pc_hazard*/instruction_out,pc_out);
Hazard_unit ins4(clk,MEM_out,Loadregout,instruction_out,pc_out,pc,IFIDwrite,Select);
register ins5(instruction_out[19:15],instruction_out[24:20],data_frommux,clk,instruction_out[11:7],WB_out_MEMWB[0],data1,data2);
immediategenerate ins6(instruction_out,imm);
nbitadder ins17(pc_out,imm,muxDin2);
control ins7(instruction_out[6:0],clk,MEM_in[0],MEM_in[2],WB_in[1],EX_in[2:1],MEM_in[1],EX_in[0],WB_in[0]);
assign con={EX_in,MEM_in,WB_in};
Branch_Predictor ins18(data1,data2,MEM_in[0],equal);
mux21 #(.N(8)) insC(con,zero,Select,muxCout);
ID_EX ins8(clk,muxCout[7:5],muxCout[4:2],muxCout[1:0],instruction_out[19:15],instruction_out[24:20],instruction_out[11:7],imm,instruction_out,
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

module Multipath_tb #();

reg clk;
initial begin
    clk<=1'b0;
end

Multipath uut1(clk);

initial begin
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
    #50 clk=1'b0;
    #50 clk=1'b1;
end

endmodule