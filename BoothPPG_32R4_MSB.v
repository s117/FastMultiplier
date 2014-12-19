module BoothPPG_32R4_MSB(mulcand,msb,sign,pp);
input wire[31:0] mulcand;
input wire msb;
input wire sign;

output wire[31:0] pp;

assign pp = ((sign == 0)&&(msb == 1))? mulcand : 32'b0;
    
endmodule
