module CSA(a,b,cin,sum,cout);
parameter bits = 4;

input wire [bits-1:0] a;
input wire [bits-1:0] b;
input wire [bits-1:0] cin;
output wire [bits-1:0] sum;
output wire [bits-1:0] cout;

assign sum = a^b^cin;
assign cout = (a&b) | (a&cin) | (b&cin);

endmodule
