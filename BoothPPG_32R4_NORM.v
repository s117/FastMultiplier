module BoothPPG_32R4_NORM(mulcand, r4input, sign, pp);
input wire [31:0] mulcand;
input wire [2:0] r4input;
input wire sign;

output wire[33:0] pp;

wire[32:0] raw;

assign raw[32:0] = (r4input[1]^r4input[0] === 0)?
    ((r4input[2]^r4input[0] === 0)?0:{mulcand[31:0], 1'b0}):
    ((sign === 0)?{1'b0, mulcand[31:0]}:{mulcand[31], mulcand[31:0]});

genvar i;
generate
    for(i = 0;i <= 32; i = i+1) begin
        assign pp[i] = raw[i]^r4input[2];
    end
endgenerate

assign pp[33] = (sign === 0)?r4input[2]:pp[32];
    
endmodule
