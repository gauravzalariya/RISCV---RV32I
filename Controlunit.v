`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:27:05 04/25/2020 
// Design Name: 
// Module Name:    Controlunit 
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
module Controlunit(ins,op_dec,imm,immsel,enloadsize,enbranch,seldmresult,selrw,dm_en,dm_rw
    );
input [31:0] ins;
output [3:0] op_dec;
output [11:0] imm;
output immsel;
output [1:0] enloadsize;
output [1:0] enbranch;
output seldmresult;
output selrw;
output dm_en;
output dm_rw; //0 for read 1 for write

assign op_dec = (({ins[31:25],ins[14:12],ins[6:0]} == 17'b00000000000110011) || ({ins[14:12],ins[6:0]} == 10'b0000010011) || (ins[6:0] == 7'b0000011) || (ins[6:0] == 7'b0100011)) ? 4'b0000 : ((({ins[31:25],ins[14:12],ins[6:0]} == 17'b01000000000110011) || ({ins[14:12],ins[6:0]} == 10'b0110010011) || ({ins[14:12],ins[6:0]} == 10'b0001100011) || ({ins[14:12],ins[6:0]} == 10'b0011100011) ) ? 4'b0001 : ((({ins[14:12],ins[6:0]} == 10'b0010110011) || ({ins[14:12],ins[6:0]} == 10'b0010010011)) ? 4'b0110 : ((({ins[31:25],ins[14:12],ins[6:0]} == 17'b00000001010110011) || ({ins[31:25],ins[14:12],ins[6:0]} == 17'b00000001010010011)) ? 4'b0111 : ((({ins[31:25],ins[14:12],ins[6:0]} == 17'b01000001010110011) || ({ins[31:25],ins[14:12],ins[6:0]} == 17'b01000001010010011)) ? 4'b1000 : ((({ins[14:12],ins[6:0]} == 10'b1100110011) || ({ins[14:12],ins[6:0]} == 10'b1100010011)) ? 4'b0011 : ( (({ins[14:12],ins[6:0]} == 10'b1110110011) || ({ins[14:12],ins[6:0]} == 10'b1110010011)) ? 4'b0100 : ((({ins[14:12],ins[6:0]} == 10'b1000110011) || ({ins[14:12],ins[6:0]} == 10'b1000010011)) ? 4'b0101 : 4'b0010 ) ) ) ) ) ) ) ;

assign imm = ((ins[6:0] == 0000011) || (ins[6:0] == 0010011)) ? ins[31:20] : ((ins[6:0] == 0100011) ? ({ins[31:25],ins[11:7]}) : ((ins[6:0] == 1100011) ? ({ins[31],ins[7],ins[30:25],ins[11:8]}) : 12'b000000000000) );

assign immsel = ((ins[6:0] == 0000011) || (ins[6:0] == 0010011) || (ins[6:0] == 0100011) || (ins[6:0] == 1100011)) ? 1'b1 : 1'b0 ;

assign enloadsize = (ins[6:0] == 0100011) ? ins[13:12] : 2'b11 ;

assign enbranch = (ins[6:0] == 1100011) ? {1'b1,ins[12]} : 2'b00 ;

assign seldmresult = (ins[6:0] == 0000011) ? 1'b1 : 1'b0 ;

assign selrw = (ins[6:0] == 0100011) ? 1'b1 : 1'b0 ;

assign dm_en = ((ins[6:0] == 0000011) || (ins[6:0] == 0100011)) ? 1'b1 : 1'b0 ;

assign dm_rw = (ins[6:0] == 0100011) ? 1'b1 : 1'b0 ;

endmodule
