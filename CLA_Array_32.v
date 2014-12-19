module CLA_Array_32(a, b, cin, result, cout);
input wire[31:0] a;
input wire[31:0] b;
input wire cin;

output wire [31:0] result;
output wire cout;

wire Pi[7:0];
wire Gi[7:0];

wire Cio[7:0];
wire Cii[7:0];

genvar i;
generate
    for(i = 0;i < 8;i = i+1) begin : b4csa_array
        CLA #4 inst(a[i*4+3:i*4], b[i*4+3:i*4], Cii[i], result[(i*4+3):(i*4)], Cio[i], Pi[i], Gi[i]);
    end
endgenerate

assign Cii[0] = cin;
assign Cii[1] = Cio[0];
assign Cii[2] = Cio[1];
assign Cii[3] = Cio[2];
assign Cii[4] = Cio[3];
assign Cii[5] = Cio[4];
assign Cii[6] = Cio[5];
assign Cii[7] = Cio[6];
assign cout = Cio[7];

endmodule
