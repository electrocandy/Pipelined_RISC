module immediategenerate #(parameter N=32)
(input [N-1:0]instruction,output [N-1:0]imm);

reg [N-1:0] immed;

always@(*) begin
case(instruction[6:0])
7'b0000011: immed={{{N-12}{instruction[31]}},instruction[31:20]};
7'b0100011: immed={{{N-12}{instruction[31]}},instruction[31:25],instruction[11:7]};
7'b1100011: immed={{{N-12}{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
default: immed={{N}{1'b0}};
endcase
end

assign imm=immed;

endmodule