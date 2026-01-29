// Code your design here
module ALU_32bit (
    input [31:0] A, B,
    input [3:0] ALUControl,
    output reg [31:0] Result,
    output Zero
);
    always @(*) begin
        case (ALUControl)
            4'b0000: Result = A & B;     // and
            4'b0001: Result = A | B;     // OR
            4'b0010: Result = A + B;     // ADD
            4'b0110: Result = A - B;     // SUB
            4'b1100: Result = ~(A | B);  // NOR
            4'b1110: Result = A ^ B;     // XOR
            default: Result = 32'h00000000;
        endcase
    end
  
    assign Zero = (Result == 32'b0);
endmodule
module RAM (
    input clk,
    input we,
    input [7:0] addr,
    input [31:0] din,
    output reg [31:0] dout
);
    reg [31:0] mem [255:0];

    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;
        dout <= mem[addr];
    end
endmodule
module ProgramCounter (
    input clk,
    input reset,
    input [31:0] nextPC,
    output reg [31:0] PC
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 0;
        else
            PC <= nextPC;
    end
endmodule
module ControlUnit (
    input [2:0] opcode,
    output reg [3:0] ALUControl,
    output reg MemWrite
);
    always @(*) begin
        case (opcode)
            3'b000: begin ALUControl = 4'b0010; MemWrite = 0; end // ADD
            3'b001: begin ALUControl = 4'b0110; MemWrite = 0; end // SUB
            3'b010: begin ALUControl = 4'b0000; MemWrite = 0; end // AND
            3'b011: begin ALUControl = 4'b0001; MemWrite = 0; end // OR
            3'b100: begin ALUControl = 4'b0010; MemWrite = 1; end // ADD + STORE
            default: begin ALUControl = 4'b0000; MemWrite = 0; end
        endcase
    end
endmodule
module TopModule (
    input clk,
    input reset,
    input [2:0] opcode,
    input [31:0] A, B,
    input [7:0] addr,
    output [31:0] alu_out,
    output [31:0] mem_out,
    output [31:0] PC_out
);
    wire [3:0] ALUControl;
    wire MemWrite;
    wire [31:0] ALUResult;
    wire Zero;
    reg [31:0] nextPC;

    // Instantiate modules
    ALU_32bit alu(.A(A), .B(B), .ALUControl(ALUControl), .Result(ALUResult), .Zero(Zero));
    RAM ram(.clk(clk), .we(MemWrite), .addr(addr), .din(ALUResult), .dout(mem_out));
    ControlUnit cu(.opcode(opcode), .ALUControl(ALUControl), .MemWrite(MemWrite));
    ProgramCounter pc(.clk(clk), .reset(reset), .nextPC(nextPC), .PC(PC_out));

    assign alu_out = ALUResult;

    always @(*) begin
        nextPC = PC_out + 4;  // Simple increment by 4
    end
endmodule
