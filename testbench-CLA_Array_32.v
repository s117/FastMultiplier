module testbench_CLA_Array_32();
reg[31:0] a;
reg[31:0] b;
reg cin;

wire[31:0] result;
wire cout;
wire[32:0] expectOutput;
reg errorFlag = 0;

integer i;

assign expectOutput = a + b + cin;

initial begin 
    a = 32'h11111111;
    b = 32'hffffffff;
    cin = 1;
    #10;
    if ({cout,result} !== expectOutput) begin
        errorFlag = 1;
        $display("test fail: expect %x + %x = %x, actual %x", a, b, expectOutput, {cout,result});
    end

    a = 32'h00000000;
    b = 32'hffffffff;
    cin = 1;
    #10;
    if ({cout,result} !== expectOutput) begin
        errorFlag = 1;
        $display("test fail: expect %x + %x = %x, actual %x", a, b, expectOutput, {cout,result});
    end

    a = 32'h11111111;
    b = 32'heeeeeeee;
    cin = 1;
    #10;
    if ({cout,result} !== expectOutput) begin
        errorFlag = 1;
        $display("test fail: expect %x + %x = %x, actual %x", a, b, expectOutput, {cout,result});
    end

    for(i = 0;i < 32'hffff; i = i+1) begin
        a = $random();
        b = $random();
        cin = ($random()&1);
        #10;
        if ({cout,result} !== expectOutput) begin
            errorFlag = 1;
            $display("test fail: expect %x + %x = %x, actual %x", a, b, expectOutput, {cout,result});
        end
    end

    if (errorFlag === 0) begin
        $display("Test passed");
    end
    else begin
        $display("Test failed");
    end
end

CLA_Array_32 cla(.a(a), .b(b), .cin(cin), .result(result), .cout(cout));

endmodule
