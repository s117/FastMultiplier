module testbench_BoothPPG_32R4_MSB();
reg[31:0] mulcand;
reg msb;
reg sign;

wire[31:0] pp;

BoothPPG_32R4_MSB ppg(.mulcand(mulcand), .msb(msb), .sign(sign), .pp(pp));

task check(input[31:0] cand);
    reg[31:0] expectPP;
    reg errorFlag;
    begin
        errorFlag = 0;
        mulcand = cand;
        
        sign = 1;

        msb = 1;
        expectPP = 0;
        #10;
        if (pp !== expectPP) begin
            $display("fail: mulcand = %x, msb = %1b, sign = %1b, expect pp = %x, but actual pp = %x", mulcand, msb, sign, expectPP, pp);
            errorFlag = 1;
        end

        msb = 0;
        expectPP = 0;
        #10;
        if (pp !== expectPP) begin
            $display("fail: mulcand = %x, msb = %1b, sign = %1b, expect pp = %x, but actual pp = %x", mulcand, msb, sign, expectPP, pp);
            errorFlag = 1;
        end
        
        sign = 0;
        
        msb = 1;
        expectPP = mulcand;
        #10;
        if (pp !== expectPP) begin
            $display("fail: mulcand = %x, msb = %1b, sign = %1b, expect pp = %x, but actual pp = %x", mulcand, msb, sign, expectPP, pp);
            errorFlag = 1;
        end
        
        msb = 0;
        expectPP = 0;
        #10;
        if (pp !== expectPP) begin
            $display("fail: mulcand = %x, msb = %1b, sign = %1b, expect pp = %x, but actual pp = %x", mulcand, msb, sign, expectPP, pp);
            errorFlag = 1;
        end
        if(errorFlag === 0) begin
            $display("mulcand = %x passed", cand);
        end
        else begin
            $display("mulcand = %x failed", cand);
        end
    end
endtask

integer loopchk;

initial begin
    for(loopchk = 0; loopchk < 100; loopchk = loopchk+1) begin
        check($random());
    end
    check(32'h00000001);
    check(32'h00000001);
    check(32'h10000001);
    check(32'hffffffff);
    check(32'hdeadbeef);
end


endmodule
