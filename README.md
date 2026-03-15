# Asynchronous FIFO in Verilog with Almost Full / Almost Empty Flags

## Overview

This repository contains a **parameterized asynchronous FIFO implementation in Verilog HDL** designed for safe data transfer between two independent clock domains.

The design uses **Gray-code pointer synchronization** and **two-stage synchronizers** to mitigate metastability during clock domain crossing (CDC).

The FIFO supports the following status signals:

- Full
- Empty
- Almost Full
- Almost Empty

These signals help upstream and downstream modules control data flow and avoid overflow or underflow.

---

## Motivation

Modern digital systems frequently contain multiple modules operating under **different clock domains**. Direct data transfer between such modules can lead to:

- Metastability
- Data corruption
- Timing hazards

An **asynchronous FIFO** provides a reliable solution for buffering data between independent clocks.

---

## Key Features

- Parameterized FIFO depth
- Parameterized data width
- Gray-code pointer synchronization
- Two-flop synchronizers for CDC safety
- Full and Empty detection
- Almost Full / Almost Empty early warning flags
- Dual-port memory implementation
- Multi-clock testbench verification

---

## Architecture

The FIFO consists of two independent domains:

### Write Clock Domain
Responsible for writing incoming data into the FIFO.

Components:
- Binary write pointer
- Gray code conversion
- Full detection logic

### Read Clock Domain
Responsible for reading data from the FIFO.

Components:
- Binary read pointer
- Gray code conversion
- Empty detection logic

### Clock Domain Synchronization

Pointers are transferred between clock domains using:

- Gray code encoding
- Two-stage flip-flop synchronizers

This ensures safe pointer comparison across clock boundaries.

---

## FIFO Architecture Diagram

    WRITE DOMAIN                    READ DOMAIN

  +---------------+            +---------------+
  | Write Pointer |            | Read Pointer  |
  |  Binary       |            |  Binary       |
  +-------+-------+            +-------+-------+
          |                            |
          v                            v
   +--------------+             +--------------+
   | Gray Encode  |             | Gray Encode  |
   +------+-------+             +------+-------+
          |                            |
          v                            v
     +---------+                 +---------+
     | Sync    |                 | Sync    |
     | r2w     |                 | w2r     |
     +----+----+                 +----+----+
          |                            |
          v                            v
      +------------------------------------+
      |           FIFO MEMORY              |
      |         (Dual Port RAM)            |
      +------------------------------------+



      
---

## Modules

| Module | Description |
|------|-------------|
| `Aynchrnous_FIFO_with_Almost_Empty_Full_flag` | Top FIFO module |
| `fifo_mem` | Dual-port FIFO memory |
| `sync_w2r` | Write pointer synchronizer |
| `sync_r2w` | Read pointer synchronizer |
| `full_with_almost` | Full and almost-full logic |
| `empty_with_almost` | Empty and almost-empty logic |
| `clock_divider` | Generates independent read/write clocks for simulation |

---

## Parameters

The FIFO is configurable through parameters.

| Parameter | Description |
|--------|-------------|
| WIDTH | Data width |
| DEPTH | FIFO depth |
| ALMOST_FULL_MARGIN | Threshold for almost-full |
| ALMOST_EMPTY_MARGIN | Threshold for almost-empty |

Example:

```verilog
parameter WIDTH = 4;
parameter DEPTH = 8;

