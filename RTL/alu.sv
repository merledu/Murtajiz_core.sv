module alu (
input logic [5:0] ALU_Control,
input logic [31:0] operand_A,operand_B,
input logic [4:0] shamt,
output logic [31:0] ALU_result);
assign shamt = operand_B[4:0];
always_comb begin 
   ALU_result= 
            (ALU_Control == 6'b000_000)? operand_A + operand_B:                /* ADD, ADDI*/
            (ALU_Control == 6'b001_000)? operand_A - operand_B:                /* SUB */
            (ALU_Control == 6'b000_100)? operand_A ^ operand_B:                /* XOR, XORI*/
            (ALU_Control == 6'b000_110)? operand_A | operand_B:                /* OR, ORI */
            (ALU_Control == 6'b000_111)? operand_A & operand_B:                /* AND, ANDI */
            (ALU_Control == 6'b000_010)? {31'b0,operand_A < operand_B}:                /* SLT, SLTI */
            (ALU_Control == 6'b000_011)? {31'b0,operand_A < operand_B}:                /* SLTU, SLTIU */
            (ALU_Control == 6'b000_001)? operand_A << shamt:                   /* SLL, SLLI => 0's shifted in from right */
            (ALU_Control == 6'b000_101)? operand_A >> shamt:                   /* SRL, SRLI => 0's shifted in from left */
            (ALU_Control == 6'b001_101)? operand_A >> shamt:                   /* SRA, SRAI => sign bit shifted in from left */
            (ALU_Control == 6'b111_111)? operand_A:                            /* operand_A = PC+4 for JAL */
            (ALU_Control == 6'b010_000)? {31'b0,operand_A == operand_B}:             /* BEQ */
            (ALU_Control == 6'b010_001)? {31'b0,operand_A != operand_B}:             /* BNE */
            (ALU_Control == 6'b010_100)? {31'b0,operand_A < operand_B}:              /* BLT */
            (ALU_Control == 6'b010_101)? {31'b0,operand_A >= operand_B}:             /* BGE */
            (ALU_Control == 6'b010_110)? {31'b0,operand_A < operand_B}:              /* BLTU */
            (ALU_Control == 6'b010_111)? {31'b0,operand_A >= operand_B}: 32'b0;          /* BGEU */
end
endmodule 