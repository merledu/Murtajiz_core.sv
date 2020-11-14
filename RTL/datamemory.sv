module datamemory (
input logic clk , reset , memread , memwrite ,
input logic [31:0] aluresult ,  rs2 , 
input logic [9:0] alu_addr ,
output logic [31:0] writedata_to_reg ,
output logic [31:0] data_in );
logic [31:0] datamem [0:1023]; 
//LOAD
always_comb begin
if ( reset == 1'b0) begin 
if (memread == 1'b1) 
writedata_to_reg = datamem[alu_addr] ; 
else
writedata_to_reg = aluresult ;
end
end
//STORE
always@(posedge clk) begin
if (memwrite == 1'b1) 
datamem[alu_addr] <= rs2 ;
end
always_comb
data_in = datamem[alu_addr];
endmodule 
