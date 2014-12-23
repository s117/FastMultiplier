module testbench_FastMultiplier();

reg[31:0] mulcand;
reg[31:0] muler;

reg[31:0] mulcand_U;
reg[31:0] muler_U;

integer mulcand_S;
integer muler_S;

supply0 ZERO_BIT;
supply1 SET_BIT;

wire[63:0] expectProduct_U;
wire[63:0] expectProduct_S;

wire[63:0] product_U;
wire[63:0] product_S;

always @(*) begin
    mulcand_U = mulcand;
    muler_U = muler;
    mulcand_S = mulcand;
    muler_S = muler;
end

assign expectProduct_S = mulcand_S * muler_S;
assign expectProduct_U = mulcand_U * muler_U;

FastMultiplier sm(mulcand_S, muler_S, SET_BIT, product_S);
FastMultiplier um(mulcand_U, muler_U, ZERO_BIT, product_U);

integer i;
reg errorFlag = 0;

task check(input[31:0] cand, input[31:0] er);
begin
    mulcand = cand;
    muler = er;
    #10;
    if (product_U !== expectProduct_U) begin
        errorFlag = 1;
        $display("unsigned test fail: expect %d * %d = %d, actual %d", mulcand_U, muler_U, expectProduct_U, product_U);
    end
    if (product_S !== expectProduct_S) begin
        errorFlag = 1;
        $display("signed test fail: expect %d * %d = %d, actual %d", mulcand_S, muler_S, expectProduct_S, product_S);
    end
end
endtask


initial begin
    for(i = 0;i < 32'hffff; i = i+1) begin
        check($random(), $random());
    end

    check(10, -1);
    check(10, 9);
    check(-1, 10);
    check(9, 10);
    check(-1, 9);
    check(-1, -1);
    check(0, 0);
    check(32'hffffffff,32'hffffffff);
    check(32'h80000000, 6);
    check(32'h80000000, 14);
    check(32'h80000000, 2);
    

    if (errorFlag === 0) begin
        $display("Test passed");
    end
    else begin
        $display("Test failed");
    end
end



endmodule
