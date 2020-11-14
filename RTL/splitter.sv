module splitter 
(
input logic [31:0] d_instr , pc_splitter , aluresult ,
output logic [6:0] opcode ,
output logic [4:0] rs1,rs2,rd,
output logic [2:0] funct3,
output logic [6:0] funct7,
output logic [19:0] instrmem_addr,
output logic [9:0] datamem_addr );
always_comb begin
opcode = d_instr[6:0];
rd = d_instr[11:7];
rs1 = d_instr[19:15];
rs2 = d_instr[24:20];
funct3 = d_instr[14:12];
funct7 = d_instr[31:25];
instrmem_addr = pc_splitter[21:2];
datamem_addr = aluresult[9:0];
end
endmodule
