`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:52:35 04/25/2020 
// Design Name: 
// Module Name:    Data_Memory_Block 
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
module Data_Memory_Block(ans_ex,B_Bypass,seldmresult,dm_en,dm_rw,rw_in,rw_out,writedata,clk
    );
input clk;
input [31:0] ans_ex,B_Bypass;
input seldmresult,dm_en,dm_rw;
output reg [4:0] rw_out;
input [4:0] rw_in;
output reg [31:0] writedata;

wire [31:0] writedata_temp;
wire [31:0] dmout;
assign writedata_temp = (seldmresult == 1'b1) ? dmout : ans_ex ;

//ROM-IP Core with 32(Width) x 512(Depth) with enable
DM_Block inst1 (
  .clka(clk), // input clka
  .ena(dm_en), // input ena
  .wea(dm_rw), // input [0 : 0] wea
  .addra(ans_ex), // input [8 : 0] addra
  .dina(B_Bypass), // input [31 : 0] dina
  .douta(dmout) // output [31 : 0] douta
);

 

//Sequential Block for assigning outputs at positive edge of the clock
always@(posedge clk)
begin
	rw_out <= rw_in;
	writedata <= writedata_temp; 
end


endmodule
