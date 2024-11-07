module mux31 #(parameter N=32)(input [N-1:0]A,input [N-1:0]B,input [N-1:0]C,input [1:0]Select,output [N-1:0]data);

assign data=(Select==2'b00)?A:(Select==2'b01)?B:C;

endmodule