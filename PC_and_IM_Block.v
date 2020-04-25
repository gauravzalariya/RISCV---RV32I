`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:40:53 04/25/2020 
// Design Name: 
// Module Name:    PC_and_IM_Block 
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
module PC_and_IM_Block(bjumppc,pcsrc,reset,clk,ins,current_address_out
    );
input [31:0] bjumppc;
input pcsrc,clk,reset;
output reg [31:0] ins;
output reg [31:0] current_address_out;


wire [31:0] ins_temp,ins_tempr;
wire [31:0] current_address_temp,current_address,increment_temp,increment_temp_r;
reg [31:0] next_address;

assign current_address =(pcsrc==1'b0)?next_address:bjumppc;

//Implementation of increment to Increment current address
assign increment_temp=current_address+1'b1;


//ROM-IP Core with 32(Width) x 256(Depth) with enable
IM_Block inst1 (
  .clka(clk), // input clka
  .ena(1'b1), // input ena
  .addra(current_address_temp), // input [31 : 0] addra
  .douta(ins_temp) // output [31 : 0] douta
);

//For reset condition
assign increment_temp_r = (reset == 1'b0) ? 8'b0000_0000 : increment_temp;
assign current_address_temp = (reset == 1'b0) ? 8'b0000_0000 : current_address;

assign ins_tempr = (reset == 1'b0) ? 32'b0000_0000_0000_0000_0000_0000_0000_0000 : ins_temp;

//Sequential Block for assigning outputs at positive edge of the clock
always@(posedge clk)
begin
   next_address<=increment_temp_r;
	ins <= ins_tempr;
	current_address_out <= 	current_address_temp;
end



endmodule
