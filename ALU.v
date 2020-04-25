`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:06 04/24/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(A,B,flag_ex,ans_ex,op_dec
    );
input [31:0] A,B;
input [3:0] op_dec;
output [2:0] flag_ex;
output [31:0] ans_ex;

//Declaration of wires
wire [31:0] ans_temp1,ans_temp2,ans_temp3,ans_temp4,ans_temp5,ans_temp6,ans_temp7,ans_temp8,ans_temp9;
wire [2:0] flag_ex1,flag_ex2,flag_ex3,flag_ex4,flag_ex5,flag_ex6,flag_ex7,flag_ex8,flag_ex9;

wire carry_add_temp;
wire carry_sub_temp;
wire previous_carry_add;
wire previous_carry_sub;


//ADD(A+B)
assign {previous_carry_add,ans_temp1[30:0]} =( A[30:0] + B[30:0]);
assign {carry_add_temp,ans_temp1[31]} = (A[31] + B[31] + previous_carry_add);
assign flag_ex1[2] =   previous_carry_add ^ carry_add_temp;
assign flag_ex1[0] =  (flag_ex1[2]&carry_add_temp) + ((~flag_ex1[2])&ans_temp1[31]);
assign flag_ex1[1] =  (ans_temp1 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;

//SUB(A-B)
wire [31 : 0] comp_B = (~B) + 1'b1;
assign {previous_carry_sub,ans_temp2[30:0]} =( A[30:0] + comp_B[30:0]);
assign {carry_sub_temp,ans_temp2[31]} = (A[31] + comp_B[31] + previous_carry_sub);
assign flag_ex2[2] = previous_carry_sub ^ carry_sub_temp;
assign flag_ex2[1] =  (ans_temp2 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;
assign flag_ex2[0] =  (flag_ex2[2]&carry_sub_temp) + ((~flag_ex2[2])&ans_temp2[31]);

//SLT
assign ans_temp3 = (flag_ex2[2]==1'b1)?(32'b0000_0000_0000_0000_0000_0000_0000_0001):(32'b0000_0000_0000_0000_0000_0000_0000_0000);
assign flag_ex3[2] = 1'b0;
assign flag_ex3[1] =  (ans_temp3 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;
assign flag_ex3[0] =  1'b0;

//AND(A&B)
assign ans_temp4 = A & B;
assign flag_ex4[0] = 1'b0;
assign flag_ex4[2] = 1'b0;
assign flag_ex4[1] = (ans_temp4 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;

//OR(A|B)
assign ans_temp5 = A | B;
assign flag_ex5[0] = 1'b0;
assign flag_ex5[2] = 1'b0;
assign flag_ex5[1] = (ans_temp5 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;

//XOR(A^B)
assign ans_temp6 = A ^ B;
assign flag_ex6[0] = 1'b0;
assign flag_ex6[2] = 1'b0;
assign flag_ex6[1] = (ans_temp6 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;

//Left Shift(A<<B)
assign ans_temp7 = A<<B;
assign flag_ex7[0] = 1'b0;
assign flag_ex7[2] = 1'b0;
assign flag_ex7[1] = (ans_temp7 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;

//Right Shift(A>>B)
assign ans_temp8 = A>>B;
assign flag_ex8[0] = 1'b0;
assign flag_ex8[2] = 1'b0;
assign flag_ex8[1] = (ans_temp8 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;

//Arithmatic Right Shift(A>>>B)
assign ans_temp9 = $signed(A)>>>B;
assign flag_ex9[0] = 1'b0;
assign flag_ex9[2] = 1'b0;
assign flag_ex9[1] = (ans_temp9 == 32'b0000_0000_0000_0000_0000_0000_0000_0000) ? 1'b1 : 1'b0;

//Decide ans and flag based on Opcode
assign ans_ex = ((op_dec==4'b0000) ? ans_temp1 : (((op_dec==4'b0001) ? ans_temp2 : (((op_dec==4'b0010) ? ans_temp3 : (((op_dec==4'b0011) ? ans_temp4 : (((op_dec==4'b0100) ? ans_temp5 : (((op_dec==4'b0101) ? ans_temp6 : (((op_dec==4'b0110) ? ans_temp7 : (((op_dec==4'b0111) ? ans_temp8 :  ans_temp9)))))))))))))));
assign flag_ex = ((op_dec==4'b0000) ? flag_ex1 : (((op_dec==4'b0001) ? flag_ex2 : (((op_dec==4'b0010) ? flag_ex3 : (((op_dec==4'b0011) ? flag_ex4 : (((op_dec==4'b0100) ? flag_ex5 : (((op_dec==4'b0101) ? flag_ex6 : (((op_dec==4'b0110) ? flag_ex7 : (((op_dec==4'b0111) ? flag_ex8 :  flag_ex9)))))))))))))));

endmodule
