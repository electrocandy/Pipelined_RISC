module instruction_memory #(parameter N=32,parameter M=256)
(input [N-1:0]address,input clk,output [N-1:0]instruction);

reg [N-1:0] mem[M-1:0];
reg [N-1:0]ins1=0;

initial begin
mem[0]=32'b00000000001000001000000110110011; //add r3,r1,r2
mem[1]=32'b01000000001000001000001000110011; //sub r4,r1,r2
mem[2]=32'b0000000000100000111001010110011; //and r5,r1,r2
mem[3]=32'b00000000001000001110001100110011; //or r6,r1,r2
mem[4]=32'b00000000001001010000000101100011; //beq r10,r2,1
// Here BEQ instruction is not implemented in terms of byte offset but directly in terms of instruction which is to be jumped
// So Left shift not used 
mem[5]=32'b00000000010000000100010000000011; //lw r8,4(r0)
mem[6]=32'b00000000100100000000001000100011; //sw r9,4(r0) 
mem[7]=32'b00000000001000001000011000110011; //add r12,r1,r2
mem[8]=32'b0000000000100000100011010110011; //xor r13,r1,r2
end

always@(*)begin
ins1=mem[address];
end

assign instruction=ins1;

endmodule