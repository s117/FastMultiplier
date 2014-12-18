module FA(input wire a, input wire b, input wire ci, output wire sum, output wire co);
    assign sum = a^b^ci;
    assign co = a&b | a&ci | b&ci;
endmodule
