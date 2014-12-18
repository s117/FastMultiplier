module HA(input wire a,input wire b,output wire sum,output wire co);
    assign sum = a^b;
    assign co = a&b;
endmodule
