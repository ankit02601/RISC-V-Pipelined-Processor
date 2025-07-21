# RISC-V-Pipelined-Processor

RISC-V 5-Stage Pipelined Processor
This repository contains the Register Transfer Level (RTL) Verilog code for a RISC-V 5-stage pipelined processor. The design implements a subset of the RV32I instruction set architecture (ISA), providing a foundational understanding of modern processor design principles.

🚀 What is a Pipelined Processor?
A pipelined processor is a CPU architecture that executes multiple instructions concurrently by overlapping their execution phases. Instead of completing one instruction entirely before starting the next, a pipeline breaks down the instruction execution into a series of smaller, sequential stages. Each stage works on a different instruction simultaneously, much like an assembly line. This parallel processing significantly improves the throughput (number of instructions completed per unit of time) of the processor.

🚦 The 5 Stages of the Pipeline
The classic 5-stage pipeline, as implemented in this design, consists of the following stages:

1-Instruction Fetch (IF): 📥

Purpose: Retrieves the next instruction from the instruction memory based on the Program Counter (PC).

Outputs: The fetched instruction and the incremented PC value (PC + 4).

2-Instruction Decode (ID): ⚙️

Purpose: Decodes the fetched instruction, identifies its type, and reads the necessary operand values from the register file. It also calculates the branch target address if the instruction is a branch.

Outputs: Control signals for subsequent stages, immediate values, and register operand values.

3-Execute (EX): ⚡

Purpose: Performs the arithmetic and logical operations specified by the instruction. This includes Arithmetic Logic Unit (ALU) operations, address calculation for memory accesses, and branch target comparison.

Outputs: ALU result, branch condition flag.

4-Memory Access (MEM): 🧠

Purpose: Handles memory operations. For load instructions, data is read from the data memory. For store instructions, data is written to the data memory.

Outputs: Loaded data (for load instructions).

5-Write Back (WB): ✍️

Purpose: Writes the result of the instruction back to the register file. This could be the ALU result, loaded data, or the incremented PC for JAL (Jump and Link) instructions.

Outputs: Updated register file.

📉 Pipelining Hazards
While pipelining significantly boosts performance, it introduces challenges known as hazards. These are situations where the ideal overlapping of instruction execution cannot be maintained, leading to stalls or incorrect results. This design addresses the following common hazards:

1-Structural Hazards: 🏢

Occur when multiple instructions simultaneously try to use the same hardware resource.

Example: If a single memory unit is used for both instruction fetch and data access, a structural hazard can arise when the IF stage needs to fetch an instruction at the same time the MEM stage needs to access data.

Mitigation in this design: Typically addressed by having separate instruction and data memories (Harvard architecture) or by carefully scheduling resource access.

2-Data Hazards: 📊

Occur when an instruction tries to read a register before a preceding instruction has written its new value to that register.

Types:

RAW (Read After Write): An instruction reads a register that a prior instruction is about to write. (Most common)

WAW (Write After Write): An instruction writes to a register before a prior instruction has written to the same register.

RAR (Read After Read): Not a hazard, as order doesn't matter.

Mitigation in this design:

Forwarding (Bypassing): The result of an operation is forwarded directly from an earlier pipeline stage to a later stage that needs it, without waiting for it to be written back to the register file. This is crucial for performance.

Stalling (Pipeline Bubbles): If forwarding isn't possible (e.g., for load-use hazards), the pipeline is stalled for one or more cycles, inserting "bubbles" (NOPs) to ensure data dependencies are met.

Control Hazards (Branch Hazards): ↩️

Occur when the pipeline fetches instructions sequentially, but a branch instruction changes the program's control flow. The processor might fetch instructions from the "wrong" path.

Example: A conditional branch instruction is in the ID or EX stage, but the IF stage has already fetched the next sequential instruction. If the branch is taken, the fetched instruction is incorrect.

Mitigation in this design:

Branch Prediction: Attempting to guess the outcome of a branch and speculatively fetch instructions.

Stalling: Flushing the pipeline and re-fetching from the correct target address after the branch outcome is resolved.

Delayed Branch: A technique where the instruction immediately following a branch is always executed, regardless of whether the branch is taken or not. (Less common in modern RISC-V designs due to complexity).

✨ Key Features & Implementation Details
RISC-V RV32I ISA Subset: Supports fundamental integer instructions including arithmetic, logical, load, store, branch, and jump instructions.

Pipelining Registers: Latches (reg or always @(posedge clk)) are strategically placed between each pipeline stage to hold the intermediate results and propagate them to the next stage.

Hazard Detection Unit: Monitors for data hazards and generates stall signals to insert bubbles when forwarding isn't sufficient (e.g., for load-use hazards).

Forwarding Unit: Implements bypassing logic to forward results from the EX and MEM stages to the ID and EX stages, minimizing stalls due to data dependencies.

Branch Prediction/Stalling Logic: Handles control hazards by either predicting branches or stalling the pipeline until the branch outcome is determined.

Separate Instruction and Data Memories: Implements a Harvard architecture to avoid structural hazards related to memory access.
