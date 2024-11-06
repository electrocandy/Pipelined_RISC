module nbitadder #(parameter N=32)(input [N-1:0]a,input [N-1:0]b,output [N-1:0]s);
genvar i;
wire [N-1:0]carry;
wire [N-1:0]fsum;
generate
for(i=0;i<32;i=i+1) begin
   if(i==0)
      half_adder ins(a[0],b[0],fsum[0],carry[0]);
   else
      full_adder inst1(a[i],b[i],carry[i-1],fsum[i],carry[i]);
end
endgenerate
assign s=fsum;
endmodule

module full_adder(input a,input b,input c,output sum,output cout);
reg sum1,cout1;
always@(a or b or c) begin
sum1=a^b^c;
cout1=(a&b)|((a^b)&c);
end
assign sum=sum1;
assign cout=cout1;
endmodule

module half_adder(input a,input b,output s,output c);
reg s1,c1;
always@(a or b)begin
s1=a^b;
c1=a&b;
end
assign s=s1;
assign c=c1;
endmodule

