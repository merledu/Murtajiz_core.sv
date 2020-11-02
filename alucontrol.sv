module ALU_Control
(
    input logic [2:0]funct3,
    input logic [6:0] funct7,
    input logic [2:0] alu_op,
    output logic [5:0]ALU_Control
);
 
always_comb begin   
     ALU_Control = (alu_op == 3'b011)? 
               6'b111_111 :      //pass for JAL and JALR
                      
               (alu_op == 3'b010)? 
               {3'b010,funct3} : //branches
               
               //R Type instructions
               ({alu_op, funct7} == {3'b000, 7'b0})? 
               {3'b000,funct3} : 
               ({alu_op, funct7} == {3'b000, 7'b0100000})? 
               {3'b001,funct3} :
                                         
               //I Type instructions
               ({alu_op, funct3, funct7} == {3'b001, 3'b101, 7'b0})? 
               {3'b000,funct3} : 
               ({alu_op, funct3, funct7} == {3'b001, 3'b101, 7'b0100000})? 
               {3'b001,funct3} : 
               ({alu_op, funct3} == {3'b001, 3'b101})? 
               {3'b000,funct3} : 
               (alu_op == 3'b001)?                  
               {3'b000,funct3} : 
               6'b000_000;      // load/store    (addition)
 end
endmodule:ALU_Control
