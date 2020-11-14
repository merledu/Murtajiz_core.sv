module instr_mem
(input logic clk , reset ,[19:0] addr,
 output logic [31:0] data_o );
 logic [31:0] mem [0:1048576];
initial 
$readmemh("C:/Users/Arsalan/Desktop/hex_file.mem",mem);
always_comb begin
if (reset == 1'b0)
data_o = mem[addr]; 
else 
data_o = 32'h0;
end
endmodule
