module FastMultiplier(mulcand, muler, sign, product);
input wire[31:0] mulcand;
input wire[31:0] muler;
input wire sign;

output wire[63:0] product;

wire[33:0] pp0;
wire[33:0] pp1;
wire[33:0] pp2;
wire[33:0] pp3;
wire[33:0] pp4;
wire[33:0] pp5;
wire[33:0] pp6;
wire[33:0] pp7;
wire[33:0] pp8;
wire[33:0] pp9;
wire[33:0] pp10;
wire[33:0] pp11;
wire[33:0] pp12;
wire[33:0] pp13;
wire[33:0] pp14;
wire[33:0] pp15;
wire[31:0] pp16;
wire[15:0] i;

wire[62:0] C;
wire[63:0] S;

supply0 CLA_cin;
wire CLA_cout;

BoothPPG_32R4 ppg (mulcand, muler, sign,
    i, pp0, pp1, pp2, pp3,
    pp4, pp5, pp6, pp7,
    pp8, pp9, pp10, pp11,
    pp12, pp13, pp14, pp15,
    pp16);

PP_Compressor compressor(i, pp0, pp1, pp2, pp3,
                        pp4, pp5, pp6, pp7,
                        pp8, pp9, pp10, pp11,
                        pp12, pp13, pp14, pp15,
                        pp16,
                    C, S);

CLA_Array #16 cla({C[62:0], 1'b0}, S[63:0], CLA_cin, product, CLA_cout);
    
endmodule
