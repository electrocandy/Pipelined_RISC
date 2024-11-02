module ALUControl(input [1:0]ALUOp,input [2:0]funct3,input funct7,output [3:0]control);

reg [3:0]contbuff=0;
always@(*)
begin
case(ALUOp)
2'b00: contbuff<=4'b0010;
2'b01: contbuff<=4'b0110;
2'b10: case({funct7,funct3})
       4'b0000: contbuff<=4'b0010;
       4'b1000: contbuff<=4'b0110;
       4'b0111: contbuff<=4'b0000;
       4'b0110: contbuff<=4'b0001;
       4'b0100: contbuff<=4'b0011; //Added for XOR

default: contbuff<=4'bxxxx;
endcase
endcase
end

assign control=contbuff;

endmodule