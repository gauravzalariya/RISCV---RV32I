`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:50:56 04/25/2020 
// Design Name: 
// Module Name:    Decode_Block 
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
module Decode_Block(writedata_wb,rw_wb,reset,clk,ins,op_dec,imm,immsel,enloadsize,enbranch,seldmresult,dm_en,dm_rw,pc_in,pc_out,A,B,rw
    );
	 
input [31:0] writedata_wb;
input [4:0] rw_wb;
input reset,clk;
input [31:0] ins,pc_in;
output reg [31:0] pc_out;
output reg [31:0] A,B;
output reg [3:0] op_dec;
output reg [11:0] imm;
output reg immsel;
output reg [1:0] enloadsize;
output reg [1:0] enbranch;
output reg seldmresult;
output reg dm_en;
output reg dm_rw; //0 for read 1 for write
output reg [4:0] rw;

wire selrw;
wire [4:0] rw_temp;
assign rw_temp = (selrw == 1'b1) ? ins[24:20] : ins[11:7] ;

wire [3:0] op_dec_temp;
wire [11:0] imm_temp;
wire immsel_temp;
wire [1:0] enloadsize_temp;
wire [1:0] enbranch_temp;
wire seldmresult_temp;
wire selrw_temp;
wire dm_en_temp;
wire dm_rw_temp; //0 for read 1 for write

Controlunit inst1(ins,op_dec_temp,imm_temp,immsel_temp,enloadsize_temp,enbranch_temp,seldmresult_temp,selrw,dm_en_temp,dm_rw_temp);


//Initialize Register Bank with Data(Will Happen only once)
reg [31:0] Reg_Bank[0 : 31];
initial
begin
	  Reg_Bank[0] = 0;
	  Reg_Bank[1] = 1;
	  Reg_Bank[2] = 2;
	  Reg_Bank[3] = 3;
	  Reg_Bank[4] = 4;
	  Reg_Bank[5] = 5;
	  Reg_Bank[6] = 6;
	  Reg_Bank[7] = 7;
	  Reg_Bank[8] = 8;
	  Reg_Bank[9] = 9;
	  Reg_Bank[10] = 10;
	  Reg_Bank[11] = 11;
	  Reg_Bank[12] = 12;
	  Reg_Bank[13] = 13;
	  Reg_Bank[14] = 14;
	  Reg_Bank[15] = 15;
	  Reg_Bank[16] = 16;
	  Reg_Bank[17] = 17;
	  Reg_Bank[18] = 18;
	  Reg_Bank[19] = 19;
	  Reg_Bank[20] = 20;
	  Reg_Bank[21] = 21;
	  Reg_Bank[22] = 22;
	  Reg_Bank[23] = 23;
	  Reg_Bank[24] = 24;
	  Reg_Bank[25] = 25;
	  Reg_Bank[26] = 26;
	  Reg_Bank[27] = 27;
	  Reg_Bank[28] = 28;
	  Reg_Bank[29] = 29;
	  Reg_Bank[30] = 30;
	  Reg_Bank[31] = 31;
end

wire [31:0] temp , temp1;
//For reset condition
assign temp = (reset == 0) ? 32'b0000_0000_0000_0000_0000_0000_0000_0000 : Reg_Bank[ins[19 : 15]];
assign temp1 = (reset == 0) ? 32'b0000_0000_0000_0000_0000_0000_0000_0000 : Reg_Bank[ins[24 : 20]];

//Sequential Block for assigning outputs at positive edge of the clock
always@(posedge clk)
begin
		A <= temp;
		B <= temp1;
		Reg_Bank[rw_wb] <= writedata_wb;
		rw <= rw_temp;
		op_dec <= op_dec_temp;
		imm <= imm_temp;
		immsel <= immsel_temp;
		enloadsize <= enloadsize_temp;
		enbranch <= enbranch_temp;
		seldmresult <= seldmresult_temp;
		dm_en <= dm_en_temp;
		dm_rw <= dm_rw_temp; //0 for read 1 for write
		pc_out <= pc_in;

end

endmodule
