module controldecode 
(output bit regwrite , memwrite ,memread , memtoreg , operandbsel , branch_o ,
output bit [1:0] operandasel , nextpcsel , extendsel ,
output logic [2:0] aluop , 
input logic [6:0] opcodes );
always_comb begin 
case(opcodes) 
//R-TYPE INSTRUCTION
7'h33 : begin
memread=1'b0;
memwrite=1'b0;
memtoreg=1'b0;
regwrite=1'b1;
branch_o=1'b0;
operandasel=2'b0;
operandbsel=1'b0;
extendsel=2'b0;
nextpcsel=2'b0;
aluop=3'b0;
end
//LOAD INSTRUCTION
7'h3 : begin
memread=1'b1;
memwrite=1'b0;
memtoreg=1'b1;
regwrite=1'b1;
branch_o=1'b0;
operandasel=2'b0;
operandbsel=1'b1;
extendsel=2'b0;
nextpcsel=2'b0;
aluop=3'b100;
end
7'h23 : begin
memread=1'b0;
memwrite=1'b1;
memtoreg=1'b0;
regwrite=1'b0;
branch_o=1'b0;
operandasel=2'b0;
operandbsel=1'b1;
extendsel=2'b10;
nextpcsel=2'b0;
aluop=3'b101;
end
7'h63 : begin
memread=1'b0;
memwrite=1'b0;
memtoreg=1'b0;
regwrite=1'b0;
branch_o=1'b1;
operandasel=2'b0;
operandbsel=1'b0;
extendsel=2'b0;
nextpcsel=2'b01;
aluop=3'b010;
end
7'h13 : begin
memread=1'b0;
memwrite=1'b0;
memtoreg=1'b0;
regwrite=1'b1;
branch_o=1'b0;
operandasel=2'b0;
operandbsel=1'b1;
extendsel=2'b0;
nextpcsel=2'b0;
aluop=3'b001;
end
7'h67 : begin
memread=1'b0;
memwrite=1'b0;
memtoreg=1'b0;
regwrite=1'b1;
branch_o=1'b0;
operandasel=2'b01;
operandbsel=1'b0;
extendsel=2'b0;
nextpcsel=2'b11;
aluop=3'b011;
end
7'h6f : begin
memread=1'b0;
memwrite=1'b0;
memtoreg=1'b0;
regwrite=1'b1;
branch_o=1'b0;
operandasel=2'b01;
operandbsel=1'b0;
extendsel=2'b0;
nextpcsel=2'b10;
aluop=3'b011;
end
7'h37 : begin
memread=1'b0;
memwrite=1'b0;
memtoreg=1'b0;
regwrite=1'b1;
branch_o=1'b0;
operandasel=2'b10;
operandbsel=1'b1;
extendsel=2'b01;
nextpcsel=2'b00;
aluop=3'b110;
end
default :  $error("Unexpected opcode=%b", opcodes); 
endcase
end
endmodule 
