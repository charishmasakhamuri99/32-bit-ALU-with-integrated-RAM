// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module TopModule_tb;

    reg clk, reset;
    reg [2:0] opcode;
    reg [31:0] A, B;
    reg [7:0] addr;
    wire [31:0] alu_out, mem_out, PC_out;

    TopModule uut (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .A(A),
        .B(B),
        .addr(addr),
        .alu_out(alu_out),
        .mem_out(mem_out),
        .PC_out(PC_out)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        $display("Time\tPC\tOpcode\tA\tB\tALU_Out\tMem_Out");
        clk = 0;
        reset = 1; #10;
        reset = 0;

        // ADD
        opcode = 3'b000; A = 32'd10; B = 32'd20; addr = 8'd5; #10;
        $display("%0t\t%0d\tADD\t%0d\t%0d\t%0d\t%0d", $time, PC_out, A, B, alu_out, mem_out);

        // SUB
        opcode = 3'b001; A = 32'd40; B = 32'd15; addr = 8'd10; #10;
        $display("%0t\t%0d\tSUB\t%0d\t%0d\t%0d\t%0d", $time, PC_out, A, B, alu_out, mem_out);

        // AND
        opcode = 3'b010; A = 32'hF0F0F0F0; B = 32'h0F0F0F0F; addr = 8'd15; #10;
        $display("%0t\t%0d\tAND\t%h\t%h\t%h\t%h", $time, PC_out, A, B, alu_out, mem_out);

        // OR
        opcode = 3'b011; A = 32'hAAAA0000; B = 32'h0000BBBB; addr = 8'd20; #10;
        $display("%0t\t%0d\tOR\t%h\t%h\t%h\t%h", $time, PC_out, A, B, alu_out, mem_out);

        // ADD + STORE
        opcode = 3'b100; A = 32'd7; B = 32'd8; addr = 8'd25; #10;
        $display("%0t\t%0d\tSTORE\t%0d\t%0d\t%0d\t%0d", $time, PC_out, A, B, alu_out, mem_out);

        $finish;
    end
endmodule
