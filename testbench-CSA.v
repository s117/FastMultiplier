module testbench_CSA();
parameter bits = 4;

reg [bits-1:0] a;
reg [bits-1:0] b;
reg [bits-1:0] cin;
wire [bits-1:0] sum;
wire [bits-1:0] cout;

integer i;
integer j;
integer k;
integer errorFlag = 0;
reg [bits-1:0] expectSum;
reg [bits-1:0] expectCout;

initial begin
    for(i = 0;i < (1<<bits-1); i = i+1) begin
        a = i;
        for(i = 0;i < (1<<bits-1); i = i+1) begin
            b = j;
            for(i = 0;i < (1<<bits-1); i = i+1) begin
                cin = k;
                #1;
                expectSum = (i^j^k);
                expectCout = (i&j)|(i&k)|(j&k);
                if( ( sum !== expectSum ) || ( cout !== expectCout ) ) begin
                    $display("%x + %x + %x, expect: sum = %x, cout = %x; actual sum = %x, cout = %x", i, j, k, expectSum, expectCout, sum, cout);
                    errorFlag = 1;
                end
            end
        end          
    end
    if (errorFlag === 0) begin
        $display("Test passed.");
    end
    else begin
        $display("Test failed.");
    end
end

CSA #bits csa(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

endmodule
