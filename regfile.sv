module regfile( 
input logic  clk_regfile , reset_regfile , regwrite_regfile ,
input logic [4:0] rd , rs1_i  , rs2_i , 
input logic [31:0] writedata,
output logic [31:0] rs1_o , rs2_o);
logic [31:0] registers [0:31] ; 
integer i;
initial begin 
for(i=0;i<32;i=i+1)
registers[i]=32'h0;
end
always @ (posedge clk_regfile ) begin
if (reset_regfile==1'b1) begin
for ( i=0 ; i<32 ; i=i+1)
registers[i] <= 32'b0; 
end
else begin
if(regwrite_regfile==1'b1) begin
if(rd==5'b0)
registers[rd] <= 32'b0;
else
registers[rd] <= writedata ; 
end
end
end
assign rs1_o = registers[rs1_i];
assign rs2_o = registers[rs2_i];
endmodule