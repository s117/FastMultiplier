module BoothPPG_32R4_NORM(mulcand, r4input, sign, pp);
input wire [31:0] mulcand;
input wire [2:0] r4input;
input wire sign;

output wire [31:0] pp;

always @(mulcand, r4input, sign) begin
    case(r4input)
//        3'b000: ;
//        3'b001: ;
//        3'b010: ;
//        3'b011: ;
//        3'b100: ;
//        3'b101: ;
//        3'b110: ;
//        3'b111: ;
        default: exp <= x;
    endcase
    
end

CLA inverser

    
endmodule
