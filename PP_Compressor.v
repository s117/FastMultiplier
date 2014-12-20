//`define ZERO_BIT 1'b0
module PP_Compressor(i, pp0, pp1, pp2, pp3,
                        pp4, pp5, pp6, pp7,
                        pp8, pp9, pp10, pp11,
                        pp12, pp13, pp14, pp15,
                        pp16,
                    C, S);
input wire[15:0] i;
input wire[33:0] pp0;
input wire[33:0] pp1;
input wire[33:0] pp2;
input wire[33:0] pp3;
input wire[33:0] pp4;
input wire[33:0] pp5;
input wire[33:0] pp6;
input wire[33:0] pp7;
input wire[33:0] pp8;
input wire[33:0] pp9;
input wire[33:0] pp10;
input wire[33:0] pp11;
input wire[33:0] pp12;
input wire[33:0] pp13;
input wire[33:0] pp14;
input wire[33:0] pp15;
input wire[31:0] pp16;
output wire[62:0] C;
output wire[63:0] S;

supply0 ZERO_BIT;

wire[33:0] C11; wire[33:0] S11;
wire[33:0] C12; wire[33:0] S12;
wire[33:0] C13; wire[33:0] S13;
wire[33:0] C14; wire[33:0] S14;

wire[33:0] C21; wire[33:0] S21;
wire[37:0] C22; wire[37:0] S22;
wire[33:0] C23; wire[33:0] S23;
wire[33:0] C24; wire[33:0] S24;

wire[39:0] C31; wire[39:0] S31;
wire[38:0] C32; wire[38:0] S32;

wire[45:0] C41; wire[45:0] S41;
wire[45:0] C42; wire[45:0] S42;

wire[46:0] C51; wire[46:0] S51;

wire[56:0] C61; wire[56:0] S61;

wire[63:0] C71; wire[63:0] S71;

assign C = C71;
assign S = S71;

CSA #34 CSA13(
	.a({{4{pp0[33]}}, pp0[33:4]}), 
	.b({{2{pp1[33]}}, pp1[33:2]}), 
	.cin(pp2[33:0]), 
	.cout(C13), .sum(S13));

CSA #34 CSA23(
	.a(pp3[33:0]), 
	.b({C13[33], C13[33:1]}), 
	.cin({{2{S13[33]}}, S13[33:2]}), 
	.cout(C23), .sum(S23));

CSA #34 CSA14(
	.a({{4{pp4[33]}}, pp4[33:4]}), 
	.b({{2{pp5[33]}}, pp5[33:2]}), 
	.cin(pp6[33:0]), 
	.cout(C14), .sum(S14));

CSA #34 CSA24(
	.a({{2{pp7[33]}}, pp7[33:2]}), 
	.b(pp8[33:0]), 
	.cin({{3{C14[33]}}, C14[33:3]}), 
	.cout(C24), .sum(S24));

CSA #34 CSA11(
	.a({{4{pp9[33]}}, pp9[33:4]}), 
	.b({{2{pp10[33]}}, pp10[33:2]}), 
	.cin(pp11[33:0]), 
	.cout(C11), .sum(S11));

CSA #34 CSA21(
	.a(pp12[33:0]), 
	.b({C11[33], C11[33:1]}), 
	.cin({{2{S11[33]}}, S11[33:2]}), 
	.cout(C21), .sum(S21));

CSA #34 CSA12(
	.a({{4{pp13[33]}}, pp13[33:4]}), 
	.b({{2{pp14[33]}}, pp14[33:2]}), 
	.cin(pp15[33:0]), 
	.cout(C12), .sum(S12));

CSA #38 CSA22(
	.a({pp16[31:0], ZERO_BIT, i[15], {pp13[3:0]}}), 
	.b({C12[32:0], ZERO_BIT, {pp14[1:0], {2{ZERO_BIT}}}}), 
	.cin({S12[33:0], ZERO_BIT, i[14], ZERO_BIT, i[13]}), 
	.cout(C22), .sum(S22));

CSA #40 CSA31(
	.a({{6{S21[33]}}, S21[33:0]}), 
	.b({C22[36:0], {3{ZERO_BIT}}}), 
	.cin({S22[37:0], ZERO_BIT, i[12]}), 
	.cout(C31), .sum(S31));

CSA #39 CSA32(
	.a({C24[33:0], ZERO_BIT, {pp7[1:0], ZERO_BIT}, ZERO_BIT}), 
	.b({S24[33], S24[33:0], {C14[2:0]}, ZERO_BIT}), 
	.cin({{5{S14[33]}}, S14[33:0]}), 
	.cout(C32), .sum(S32));

CSA #46 CSA41(
	.a({{5{C21[33]}}, C21[33:0], ZERO_BIT, {C11[0], ZERO_BIT}, {pp9[3:0]}}), 
	.b({C31[38:0], ZERO_BIT, {S11[1:0]}, {pp10[1:0], {2{ZERO_BIT}}}}), 
	.cin({S31[39:0], ZERO_BIT, i[11], ZERO_BIT, i[10], ZERO_BIT, i[9]}), 
	.cout(C41), .sum(S41));

CSA #46 CSA42(
	.a({{11{C23[33]}}, C23[33:0], ZERO_BIT}), 
	.b({{12{S23[33]}}, S23[33:0]}), 
	.cin({C32[38:0], i[6], ZERO_BIT, i[5], ZERO_BIT, i[4], ZERO_BIT, i[3]}), 
	.cout(C42), .sum(S42));

CSA #47 CSA51(
	.a({C42[45:0], ZERO_BIT}), 
	.b({{2{S32[38]}}, S32[38:0], {6{ZERO_BIT}}}), 
	.cin({S42[45], S42[45:0]}), 
	.cout(C51), .sum(S51));

CSA #57 CSA61(
	.a({C41[44:0], {7{ZERO_BIT}}, {pp4[3:0]}, ZERO_BIT}), 
	.b({S41[45:0], ZERO_BIT, i[8], ZERO_BIT, i[7], {2{ZERO_BIT}}, {pp5[1:0], {2{ZERO_BIT}}}, ZERO_BIT}), 
	.cin({{10{C51[46]}}, C51[46:0]}), 
	.cout(C61), .sum(S61));

CSA #64 CSA71(
	.a({C61[55:0], {2{ZERO_BIT}}, {C13[0], ZERO_BIT}, {pp0[3:0]}}), 
	.b({S61[56:0], ZERO_BIT, {S13[1:0]}, {pp1[1:0], {2{ZERO_BIT}}}}), 
	.cin({{11{S51[46]}}, S51[46:0], ZERO_BIT, i[2], ZERO_BIT, i[1], ZERO_BIT, i[0]}), 
	.cout(C71), .sum(S71));

endmodule
