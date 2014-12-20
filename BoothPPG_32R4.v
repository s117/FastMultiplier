module BoothPPG_32R4(a ,b, sign,
    i, pp0, pp1, pp2, pp3,
    pp4, pp5, pp6, pp7,
    pp8, pp9, pp10, pp11,
    pp12, pp13, pp14, pp15,
    pp16);

input wire[31:0] a;
input wire[31:0] b;
input wire sign;

output wire[15:0] i;
output wire[33:0] pp0;
output wire[33:0] pp1;
output wire[33:0] pp2;
output wire[33:0] pp3;
output wire[33:0] pp4;
output wire[33:0] pp5;
output wire[33:0] pp6;
output wire[33:0] pp7;
output wire[33:0] pp8;
output wire[33:0] pp9;
output wire[33:0] pp10;
output wire[33:0] pp11;
output wire[33:0] pp12;
output wire[33:0] pp13;
output wire[33:0] pp14;
output wire[33:0] pp15;
output wire[31:0] pp16;

assign i[15:0] = {b[31], b[29], b[27], b[25], b[23], b[21], b[19], b[17], b[15], b[13], b[11], b[9], b[7], b[5], b[3], b[1]};

BoothPPG_32R4_NORM ppg0( .mulcand(a), .r4input({b[1:0],1'b0}), .sign(sign), .pp(pp0));
BoothPPG_32R4_NORM ppg1( .mulcand(a), .r4input(b[3:1]),        .sign(sign), .pp(pp1));
BoothPPG_32R4_NORM ppg2( .mulcand(a), .r4input(b[5:3]),        .sign(sign), .pp(pp2));
BoothPPG_32R4_NORM ppg3( .mulcand(a), .r4input(b[7:5]),        .sign(sign), .pp(pp3));
BoothPPG_32R4_NORM ppg4( .mulcand(a), .r4input(b[9:7]),        .sign(sign), .pp(pp4));
BoothPPG_32R4_NORM ppg5( .mulcand(a), .r4input(b[11:9]),       .sign(sign), .pp(pp5));
BoothPPG_32R4_NORM ppg6( .mulcand(a), .r4input(b[13:11]),      .sign(sign), .pp(pp6));
BoothPPG_32R4_NORM ppg7( .mulcand(a), .r4input(b[15:13]),      .sign(sign), .pp(pp7));
BoothPPG_32R4_NORM ppg8( .mulcand(a), .r4input(b[17:15]),      .sign(sign), .pp(pp8));
BoothPPG_32R4_NORM ppg9( .mulcand(a), .r4input(b[19:17]),      .sign(sign), .pp(pp9));
BoothPPG_32R4_NORM ppg10(.mulcand(a), .r4input(b[21:19]),      .sign(sign), .pp(pp10));
BoothPPG_32R4_NORM ppg11(.mulcand(a), .r4input(b[23:21]),      .sign(sign), .pp(pp11));
BoothPPG_32R4_NORM ppg12(.mulcand(a), .r4input(b[25:23]),      .sign(sign), .pp(pp12));
BoothPPG_32R4_NORM ppg13(.mulcand(a), .r4input(b[27:25]),      .sign(sign), .pp(pp13));
BoothPPG_32R4_NORM ppg14(.mulcand(a), .r4input(b[29:27]),      .sign(sign), .pp(pp14));
BoothPPG_32R4_NORM ppg15(.mulcand(a), .r4input(b[31:29]),      .sign(sign), .pp(pp15));
BoothPPG_32R4_MSB  ppg16(.mulcand(a), .msb(b[31]),             .sign(sign), .pp(pp16));
    
endmodule
