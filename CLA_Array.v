module CLA_Array(a, b, cin, result, cout);
parameter width_div_4 = 16;

localparam bits = width_div_4 << 2;

input wire[bits-1:0] a;
input wire[bits-1:0] b;
input wire cin;

output wire [bits-1:0] result;
output wire cout;

wire Pi[width_div_4-1:0];
wire Gi[width_div_4-1:0];

wire Cio[width_div_4-1:0];
wire Cii[width_div_4-1:0];

genvar i;
generate
    for(i = 0;i < width_div_4;i = i+1) begin : b4csa_array
        CLA #4 inst(a[i*4+3:i*4], b[i*4+3:i*4], Cii[i], result[(i*4+3):(i*4)], Cio[i], Pi[i], Gi[i]);
    end
endgenerate

assign Cii[0] = cin;

genvar j;
generate
    for(j = 0;j < width_div_4-1;j = j+1) begin
        assign Cii[j+1] = Cio[j];
    end
endgenerate

assign cout = Cio[width_div_4-1];

endmodule

