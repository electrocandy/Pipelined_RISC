module mux21 #(parameter N=32)(input [N-1:0]A,input [N-1:0]B,input Select,output [N-1:0]data);

assign data=(Select)?A:B;

endmodule