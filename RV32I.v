`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:47 04/25/2020 
// Design Name: 
// Module Name:    RV32I 
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
module RV32I(clk,reset
    );
input clk,reset;
wire [31:0] bjumppc;
wire pcsrc;
wire [31:0] ins;
wire [31:0] pc_in;


wire [31:0] pc_out;
wire [31:0] A,B;
wire [3:0] op_dec;
wire [11:0] imm;
wire immsel;
wire [1:0] enloadsize;
wire [1:0] enbranch;
wire seldmresult;
wire dm_en;
wire dm_rw; //0 for read 1 for write
wire [4:0] rw;

wire [2:0] flag_ex;
wire [31:0] ans_ex;
wire [31:0] B_Bypass;
wire seldmresult_ex;
wire dm_en_ex;
wire dm_rw_ex; //0 for read 1 for write
wire [4:0] rw_ex;
wire [4:0] rw_dm;
wire [4:0] rw_wb;
wire [31:0] writedata;
wire [31:0] writedata_wb;


PC_and_IM_Block inst1(bjumppc,pcsrc,reset,clk,ins,pc_in);
Decode_Block inst2(writedata_wb,rw_wb,reset,clk,ins,op_dec,imm,immsel,enloadsize,enbranch,seldmresult,dm_en,dm_rw,pc_in,pc_out,A,B,rw);
ExecutionBlock inst3(op_dec,A,B,imm,reset,clk,flag_ex,ans_ex,B_Bypass,pcsrc,immsel,enloadsize,enbranch,bjumppc,pc_out,seldmresult,dm_en,dm_rw,rw,seldmresult_ex,dm_en_ex,dm_rw_ex,rw_ex);
Data_Memory_Block inst4(ans_ex,B_Bypass,seldmresult_ex,dm_en_ex,dm_rw_ex,rw_ex,rw_dm,writedata,clk);
Writeback inst5(writedata,writedata_wb,rw_wb,rw_dm,clk,reset);


endmodule
