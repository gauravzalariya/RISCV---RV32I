`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:29 04/24/2020 
// Design Name: 
// Module Name:    ExecutionBlock 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ExecutionBlock(op_dec,A,B,imm,reset,clk,flag_ex,ans_ex,B_Bypass,pcsrc,immsel,enloadsize,enbranch,bjumppc,pc,seldmresult_in,dm_en_in,dm_rw_in,rw_in,seldmresult_out,dm_en_out,dm_rw_out,rw_out
    );
input [31:0] A,B;
input [3:0] op_dec;
input [11:0] imm;
input reset,clk;
output reg [2:0] flag_ex;
output reg [31:0] ans_ex;
output reg [31:0] B_Bypass;
output pcsrc;
input immsel;
input [1:0] enloadsize;
input [1:0] enbranch;
output [31:0] bjumppc;
input [31:0] pc;
output reg seldmresult_out;
output reg dm_en_out;
output reg dm_rw_out; //0 for read 1 for write
output reg [4:0] rw_out;
input seldmresult_in,dm_en_in,dm_rw_in;
input [4:0] rw_in;


wire [2:0] flag_ex_temp;
wire [31:0] ans_ex_temp;


//imm select
wire [31:0] ALUBin;
assign ALUBin = (immsel == 1'b1) ? {{20{imm[11]}},imm} : B ;

ALU inst1(A,ALUBin,flag_ex_temp,ans_ex_temp,op_dec);

//B bypass
wire [31:0] B_Bypass_temp;
assign B_Bypass_temp = (enloadsize[1] == 1'b1) ? B :((enloadsize[0] == 1'b1)? {16'b0000000000000000,B[15:0]} : {24'b000000000000000000000000,B[7:0]});

//PC calculation for jump type ins.
assign pcsrc = enbranch[1]&(enbranch[0]^flag_ex_temp[1]);
assign bjumppc = pc + {imm,1'b0}; 

//For reset condition
wire [31:0] B_Bypass_tempr;
wire [2:0] flag_ex_tempr;
wire [31:0] ans_ex_tempr;
assign B_Bypass_tempr = (reset == 1'b0)? 32'b0000_0000_0000_0000_0000_0000_0000_0000 : B_Bypass_temp ;
assign ans_ex_tempr = (reset == 1'b0) ? 32'b0000_0000_0000_0000_0000_0000_0000_0000 : ans_ex_temp;
assign flag_ex_tempr = (reset == 1'b0) ? 3'b000 : flag_ex_temp;

//Sequential Block for assigning outputs at positive edge of the clock
always@(posedge clk)
begin
	ans_ex <= ans_ex_tempr;
	flag_ex <= flag_ex_tempr;
   B_Bypass <= B_Bypass_tempr;	  
	seldmresult_out <= seldmresult_in;
	dm_en_out <= dm_en_in;
	dm_rw_out <= dm_rw_in; //0 for read 1 for write
	rw_out <= rw_in;

end

endmodule
