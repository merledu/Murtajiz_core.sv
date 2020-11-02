module immgen
(
    input logic [31:0]instruction,
    output logic [31:0]itype_imm,
    output logic [31:0]utype_imm,
    output logic [31:0]stype_imm,
    output logic [31:0]sbtype_imm,
    output logic [31:0]ujtype_imm
);
always_comb
begin
	utype_imm = {instruction[31:12] ,12'b0 };
		begin
			if(instruction[31]==1)
				itype_imm = {20'hFFFFF, instruction[31:20]};
			else 
				itype_imm = {20'd0, instruction[31:20]};
		end
		begin
			if(instruction[31]==1)
				stype_imm = {20'hFFFFF,instruction[31:25],instruction[11:7]};
			else 
				stype_imm = {20'd0,instruction[31:25],instruction[11:7]};
		end
		begin
			if(instruction[31]==1)
				sbtype_imm = {19'h7FFFF,instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
			else 
				sbtype_imm = {19'd0,instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
		end
		begin
			if(instruction[31]==1)
				ujtype_imm = {11'h7FF ,instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
			else 
				ujtype_imm = {11'd0,instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
		end
end
endmodule
