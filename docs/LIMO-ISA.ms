 # LIMO ISA Specification

Course: CS3520 – Computer Organisation and Architecture
Project: LIMO
Version: 1.0
Status: Draft for Defence 1

## A1. Overview and Style

LIMO is a small 32-bit load-store processor derived from RV32I. Its assembly language is Sesotho.

Word/register width: 32 bits.
Rationale: Matches RV32I and keeps cross-checking with Ripes/RARS straightforward.

Architecture style: load-store; only `nka` (load) and `kenya` (store) touch memory.
Rationale: Keeps the ALU path and MEM stage simple and keeps hazard rules small.

Addressing: byte-addressed, little-endian, word-aligned.
Rationale: Matches RISC-V. Loads/stores use offsets that are multiples of 4; misaligned access is unspecified (no exceptions).

Instruction length: fixed 32 bits. Formats: R, I, S, B, J.
Rationale: Fixed length makes fetch use PC+4 and keeps decode as one step.

Memory model (simulator): separate instruction memory (4 KiB/1024 words) and data memory (1 KiB/256 words), both starting at address 0.
Rationale: Gives IF and MEM separate memories, so there is no structural hazard.

Memory model (simulator): separate instruction memory (4 KiB/1024 words) and data memory (1 KiB/256 words), both starting at address 0.
Rationale: Gives IF and MEM separate memories, so there is no structural hazard.

Reset: PC=0, all registers=0, data memory=0.
Rationale: Makes tests deterministic and repeatable.

Program end: `ema` stops fetching, drains the pipeline, and halts.
Rationale: LIMO has no exceptions or system calls, so a stop instruction is needed.

Departures from RV32I:

1. 16 registers instead of 32.
2. Field positions differ; rd is at [10:7] with 4 bits; opcode/funct3/funct7 positions are kept recognizable.
3. 14-bit immediates instead of 12; freed register bits are used for the larger immediate.
4. Branch/jump offsets count words rather than bytes because instructions are 4-byte aligned.
5. No U-type instructions (lui, auipc); optional U-type instructions are omitted because the 14-bit immediates cover the 1 KiB data memory.
6. `ema` halt uses the RISC-V custom-0 opcode.


