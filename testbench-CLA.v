module testbench_CLA();

parameter bits = 8;

reg [bits-1:0] operand1;
reg [bits-1:0] operand2;
reg carryIn;

wire [bits-1:0] result;
wire carryOut;
wire p;
wire g;

integer i;
integer j;
integer k;
reg errorFlag = 0;

reg expectG;
reg expectP;
reg expectCOut;
reg [bits-1:0] expectResult;

initial begin
    carryIn = 0;
    for(k = 0;k < 2;k = k+1) begin
        carryIn = ~carryIn;
        for(i = 0;i < (1 << bits);i = i+1) begin
            operand1 = i;
            for(j = 0;j < (1 << bits);j = j+1) begin
                operand2 = j;
                {expectG,expectResult[bits-1:0]} = operand1 + operand2;
                {expectCOut,expectResult[bits-1:0]} = operand1 + operand2 + carryIn;
                expectP = &(operand1|operand2);
                #1;
                if (expectG !== g) begin
                    errorFlag = 1;
                    $display("singal G fail: %d+%d = %d, P = %d, G = %d, CIn = %d, COut = %d",operand1,operand2,result,p,g,carryIn,carryOut);
                end
                if(expectP !== p) begin
                    errorFlag = 1;
                    $display("singal P fail: %d+%d = %d, P = %d, G = %d, CIn = %d, COut = %d",operand1,operand2,result,p,g,carryIn,carryOut);
                end
                if(expectResult !== result) begin
                    errorFlag = 1;
                    $display("result fail: %d+%d = %d, P = %d, G = %d, CIn = %d, COut = %d",operand1,operand2,result,p,g,carryIn,carryOut);
                end
                if(expectCOut !== carryOut) begin
                    errorFlag = 1;
                    $display("carry out fail: %d+%d = %d, P = %d, G = %d, CIn = %d, COut = %d",operand1,operand2,result,p,g,carryIn,carryOut);
                end
            end
        end
    end


    if(errorFlag == 0) begin
        $display("Result test pass");
    end
    else begin
        $display("Result test fail");
    end
end


CLA #bits cla(.operand1(operand1), .operand2(operand2), .carryIn(carryIn), .carryOut(carryOut), .result(result), .p(p), .g(g));

endmodule


