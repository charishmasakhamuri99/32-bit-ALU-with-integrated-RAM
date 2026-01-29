# 32-bit-ALU-with-integrated-RAM
32-bit ALU with Integrated RAM (Short Explanation)

A 32-bit ALU with integrated RAM combines computation and storage in a single datapath, similar to a basic processor.

The RAM stores 32-bit operands and results.

The ALU performs arithmetic and logic operations (ADD, SUB, AND, OR, XOR, etc.) based on an opcode.

Operands are read from RAM, processed by the ALU, and the result is written back to RAM.

A Control Unit generates ALU control and memory write signals.

A Program Counter supports sequential execution, mimicking real CPU behavior.

Why this integration matters

An ALU alone can compute but cannot retain data.

RAM enables read-modify-write operations, making the design practical.

This structure models a simplified CPU datapath used in real processors.
