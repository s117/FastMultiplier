module testbench_BoothPPG_32R4_NORM();
reg[31:0] mulcand;
reg[2:0] r4input;
reg sign;

wire[33:0] pp;

reg[33:0] expectPP;

task check(input [31:0]cand);
    reg[3:0] i;
    reg errorFlag;
    begin
        errorFlag = 0;
        mulcand = cand;
        sign =  1;

        for(i = 4'b0;i <= 4'b0111; i = i+1) begin
            r4input = i;
            case(i[2:0])
                3'b000: expectPP[32:0] = 33'b0;
                3'b001: expectPP[32:0] = {cand[31], cand[31:0]};
                3'b010: expectPP[32:0] = {cand[31], cand[31:0]};
                3'b011: expectPP[32:0] = {cand[31:0], 1'b0};
                3'b100: expectPP[32:0] = ~{cand[31:0], 1'b0};
                3'b101: expectPP[32:0] = ~{cand[31], cand[31:0]};
                3'b110: expectPP[32:0] = ~{cand[31], cand[31:0]};
                3'b111: expectPP[32:0] = ~33'b0;
            endcase
            expectPP[33] = expectPP[32];
            #10;
            if(pp !== expectPP) begin
                $display("fail: cand = %x, r4input = %3b, sign = %x, expect pp = %x, but actual pp = %x", cand , r4input, sign, expectPP, pp);
                errorFlag = 1;
            end
        end

        sign = 0;
        for(i = 4'b0;i <= 4'b0111; i = i+1) begin
            r4input = i;
            case(i[2:0])
                3'b000: expectPP[32:0] = 33'b0;
                3'b001: expectPP[32:0] = {1'b0, cand[31:0]};
                3'b010: expectPP[32:0] = {1'b0, cand[31:0]};
                3'b011: expectPP[32:0] = {cand[31:0], 1'b0};
                3'b100: expectPP[32:0] = ~{cand[31:0], 1'b0};
                3'b101: expectPP[32:0] = ~{1'b0, cand[31:0]};
                3'b110: expectPP[32:0] = ~{1'b0, cand[31:0]};
                3'b111: expectPP[32:0] = ~33'b0;
            endcase
            expectPP[33] = r4input[2];
            #10;
            if(pp !== expectPP) begin
                $display("fail: cand = %x, r4input = %3b, sign = %x, expect pp = %x, but actual pp = %x", cand , r4input, sign, expectPP, pp);
                errorFlag = 1;
            end
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

BoothPPG_32R4_NORM ppg(.mulcand(mulcand), .r4input(r4input), .sign(sign), .pp(pp));

endmodule
