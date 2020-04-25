`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:14:07 04/25/2020 
// Design Name: 
// Module Name:    Writeback 
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
module Writeback(writedata_in,writedata_out,rw_out,rw_in,clk,reset
    );
	 
input [31:0] writedata_in;
output reg [31:0] writedata_out;
output reg [4:0] rw_out;
input [4:0] rw_in;
input clk,reset;

wire [31:0] writedata_out_temp;
assign writedata_out_temp = (reset == 0) ? 32'b0000_0000_0000_0000_0000_0000_0000_0000 : writedata_in;

//Sequential Block for assigning outputs at positive edge of the clock
always@(posedge clk)
begin
	rw_out <= rw_in;
	writedata_out <= writedata_out_temp; 
end

endmodule
