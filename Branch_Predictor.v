module Branch_Predictor #(parameter N=32,parameter M=16) (input [N-1:0]pc_in, input branch_act,output [1:0]branch_pred);

reg [1:0]BHT [0:M-1];
reg [1:0]bd;
initial begin
    integer i;
    for(i=0;i<M;i=i+1) begin
        BHT[i]<=2'b11;
    end
end

wire [3:0]br=pc_in[3:0];

always@(*)begin
    if(branch_act)begin
        if(BHT[br]<2'b11)
           BHT[br]<=BHT[br]+1;
    end else begin
        if(BHT[br]>2'b00)
           BHT[br]<=BHT[br]-1;
    end
    bd=BHT[br];
end
assign branch_pred=bd;

endmodule