module testbench_CLA_Array();
localparam bits = 64;
reg[bits-1:0] a;
reg[bits-1:0] b;
reg cin;

wire[bits-1:0] result;
wire cout;
wire[bits:0] expectOutput;
reg errorFlag = 0;

integer i;

assign expectOutput = a + b + cin;

initial begin 
    a = 64'h1111111111111111;
    b = 64'hffffffffffffffff;
    cin = 1;
    #10;
    if ({cout,result} !== expectOutput) begin
        errorFlag = 1;
        $display("test fail: expect %x + %x = %x, actual %x", a, b, {cout,result}, expectOutput);
    end

    a = 64'h0000000000000000;
    b = 64'hffffffffffffffff;
    cin = 1;
    #10;
    if ({cout,result} !== expectOutput) begin
        errorFlag = 1;
        $display("test fail: expect %x + %x = %x, actual %x", a, b, {cout,result}, expectOutput);
    end

    a = 64'h1111111111111111;
    b = 64'heeeeeeeeeeeeeeee;
    cin = 1;
    #10;
    if ({cout,result} !== expectOutput) begin
        errorFlag = 1;
        $display("test fail: expect %x + %x = %x, actual %x", a, b, {cout,result}, expectOutput);
    end

    for(i = 0;i < 32'hffff; i = i+1) begin
        a = {$random(), $random()};
        b = {$random(), $random()};
        cin = ($random()&1);
        #10;
        if ({cout,result} !== expectOutput) begin
            errorFlag = 1;
            $display("test fail: expect %x + %x = %x, actual %x", a, b, {cout,result}, expectOutput);
        end
    end

    if (errorFlag === 0) begin
        $display("Test passed");
    end
    else begin
        $display("Test failed");
    end
end

CLA_Array #16 cla(.a(a), .b(b), .cin(cin), .result(result), .cout(cout));

endmodule

