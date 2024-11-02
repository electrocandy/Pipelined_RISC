module ALU #(parameter N=32)(input [N-1:0]A,input [N-1:0]B,input [3:0]control,output [N-1:0]out);

reg [N-1:0]outbuff=0;
always@(*) begin
case(control)
4'b0000: outbuff<=A&B;
4'b0001: outbuff<=A|B;
4'b0010: outbuff<=A+B;
4'b0110: outbuff<=A-B;
4'b0011: outbuff<=A^B;
endcase
end

assign out=outbuff;

endmodule
