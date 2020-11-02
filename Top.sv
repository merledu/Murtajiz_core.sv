 module core_top ;
logic clk,reset,regwrite , memwrite ,memread , memtoreg , operandbsel , branch_o ; 
logic [1:0] operandasel , nextpcsel , extendsel  ;
logic [2:0] alu_op , funct3 ;
logic [6:0] funct7 ;
logic [31:0] stype_imm , sbtype_imm , itype_imm , utype_imm , ujtype_imm ,rs1_o ,rs2_o ;
logic [31:0] operand_A,operand_B , ALU_result , pc_top , d_instr , writedata ,data_in;
logic [5:0] ALU_Control;
logic [4:0] rd ,rs1_in , rs2_in ,shamt ;
logic [19:0] instrmem_addr;
logic [9:0] datamem_addr; 
logic [6:0] opcode ;
logic [31:0] writedata_to_reg;
//INSTANTIATING CONTROL DECODE 
controldecode controldecodetop (
 .regwrite(regwrite)
,.memwrite(memwrite)
,.memread(memread)
,.memtoreg(memtoreg)
,.operandbsel(operandbsel)
,.branch_o(branch_o)
,.operandasel(operandasel)
,.nextpcsel(nextpcsel)
,.extendsel(extendsel)
,.aluop(alu_op)
,.opcodes(opcode)
);
//INSANTIATING IMMEDIATE GENERATION 
immgen immgentop (
.stype_imm(stype_imm)
,.sbtype_imm(sbtype_imm)
,.utype_imm(utype_imm)
,.ujtype_imm(ujtype_imm)
,.itype_imm(itype_imm)
,.instruction(d_instr)
);
//INSTANTIATING ALU CONTROL 
ALU_Control alucontroltop (
.funct3(funct3)
,.funct7(funct7)
,.alu_op(alu_op)
,.ALU_Control(ALU_Control)
);
//INSTANTIATING ALU
alu alutop(
 .shamt(shamt)
,.operand_A(operand_A)
,.operand_B(operand_B)
,.ALU_result(ALU_result)
,.ALU_Control(ALU_Control)
);
//INSTANTIATING SPLITTER
splitter splittertop (
 .opcode(opcode)
,.rs1(rs1_in)
,.rs2(rs2_in)
,.rd(rd)
,.funct3(funct3)
,.funct7(funct7)
,.instrmem_addr(instrmem_addr)
,.datamem_addr(datamem_addr)
,.pc_splitter(pc_top)
,.aluresult(ALU_result)
,.d_instr(d_instr)
);
//INSTANTIATING OPERAND SELECTION 
operandSel operandseltop (
 .operand_ASel(operandasel)
,.operand_BSel(operandbsel)
,.pc(pc_top)
,.extend_Sel(extendsel)
,.rs1(rs1_o)
,.rs2(rs2_o)
,.stype_imm(stype_imm)
,.sbtype_imm(sbtype_imm)
,.utype_imm(utype_imm)
,.ujtype_imm(ujtype_imm)
,.itype_imm(itype_imm)
,.operand_A(operand_A)
,.operand_B(operand_B)
);
//INSTANTIATING IFU
ifu ifutop (
 .clk(clk)
,.reset(reset)
,.opcode(opcode)
,.pc_ifu(pc_top)
,.rs1_ifu(rs1_o)
,.aluresult(ALU_result)
,.sbtype_imm_ifu(sbtype_imm)
,.itype_imm_ifu(itype_imm)
,.ujtype_imm_ifu(ujtype_imm)
);
//INSTANTIATING REGFILE
regfile regfiletop(
 .clk_regfile(clk)
,.regwrite_regfile(regwrite)
,.reset_regfile(reset)
,.rs1_o(rs1_o)
,.rs2_o(rs2_o)
,.rd(rd)
,.rs1_i(rs1_in)
,.rs2_i(rs2_in)
,.writedata(writedata)
);
//INSTANTIATING INSTRUCTION MEMORY
instr_mem instr_memtop(
 .clk(clk)
,.reset(reset)
,.data_o(d_instr)
,.addr(instrmem_addr)
);
//INSTANTIATING DATA MEMORY
datamemory datamemorytop(
 .clk(clk)
,.reset(reset)
,.memread(memread)
,.memwrite(memwrite)
,.aluresult(ALU_result)
,.rs2(rs2_o)
,.alu_addr(datamem_addr)
,.writedata_to_reg(writedata)
,.data_in(data_in)
); 
initial begin
reset=0;
clk=0;
repeat(62) #10 clk=~clk;
end 
endmodule 
