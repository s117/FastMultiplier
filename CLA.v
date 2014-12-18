module CLA(operand1, operand2, carryIn, result, carryOut, p, g);// Carry Lookahead
parameter bits = 4;

input wire [bits-1:0] operand1;
input wire [bits-1:0] operand2;
input wire carryIn;

output wire [bits-1:0] result;
output wire carryOut;
output wire p;
output wire g;

wire bitsP [bits-1:0];
wire bitsG [bits-1:0];
wire innerP [bits-1:0];
wire innerG [bits-1:0];
wire resC [bits-1:0];

assign p = innerP[bits-1];
assign g = innerG[bits-1];

assign resC[0] = carryIn;
assign innerG[0] = bitsG[0];
assign innerP[0] = bitsP[0];

genvar gi;
generate
    for(gi = 0;gi < bits;gi = gi + 1) begin
        assign bitsP[gi] = operand1[gi] | operand2[gi];             // Generate Propagate singal for each bits
        assign bitsG[gi] = operand1[gi] & operand2[gi];             // Generate Generate singal for each bits
    end
endgenerate

//assign carryOut = bitsG[bits-1] | (bitsP[bits-1] & resC[bits-1]);
assign carryOut = g | (p & carryIn);
genvar gj;
generate
    for(gj = 1;gj < bits;gj = gj + 1) begin
        assign innerG[gj] = bitsG[gj] | (bitsP[gj] & innerG[gj-1]); // Internal middle logic for generate Generate singal output (G = gi + pi*(gi-1 + pi-1*(```)))
        assign innerP[gj] = bitsP[gj] & innerP[gj-1];               // Internal middle logic for generate Propagate singal output (P = pi * pi-1 * ``` * p0)
        //assign resC[gj] = bitsG[gj-1] | (bitsP[gj-1] & resC[gj-1]); // Carry signal for calculate result
        assign resC[gj] = innerG[gj-1] | (innerP[gj-1] & carryIn); // Carry signal for calculate result
    end
endgenerate

genvar gk;
generate
    for(gk = 0;gk < bits;gk = gk + 1) begin
        assign result[gk] = operand1[gk]^operand2[gk]^resC[gk];             // Calculate result
    end
endgenerate
 
endmodule
