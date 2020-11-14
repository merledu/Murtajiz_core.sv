module ifu(
input logic clk,reset,
input [6:0] opcode,
output logic [31:0]  pc_ifu,
input [31:0] itype_imm_ifu,sbtype_imm_ifu,ujtype_imm_ifu,aluresult,rs1_ifu );
logic [31:0] pc; 
integer i;
initial pc =0;
always@(posedge clk) begin
//BRANCH CONTROLLER
if(aluresult == 32'b1 && opcode == 7'h63) 
pc = sbtype_imm_ifu + pc;
//JAL
else if (opcode == 7'h6f) 
pc = pc + ujtype_imm_ifu;
//JALR
else if (opcode == 7'h67) 
pc = rs1_ifu + itype_imm_ifu;
else 
pc <= pc+32'h4;
end
assign pc_ifu=pc;
endmodule
