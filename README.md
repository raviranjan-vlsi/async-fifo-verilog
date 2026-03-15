# 📦 Parameterized Asynchronous FIFO using Gray-Code Pointers

<p align="center">

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Domain](https://img.shields.io/badge/Domain-VLSI-orange)
![Concept](https://img.shields.io/badge/Concept-Clock%20Domain%20Crossing-green)
![Design](https://img.shields.io/badge/Design-Asynchronous%20FIFO-purple)
![License](https://img.shields.io/badge/License-MIT-brightgreen)

</p>

---

# 🚀 Overview

This project implements a **Parameterized Asynchronous FIFO (First-In First-Out) buffer** using **Gray-code pointer synchronization** to enable reliable **Clock Domain Crossing (CDC)** between two independent clock domains.

The design ensures safe data transfer between modules operating at **different clock frequencies**, which is a common requirement in **System-on-Chip (SoC) architectures**, communication interfaces, and digital hardware systems.

---

# 🎯 Key Features

✔ Parameterized FIFO depth and data width  
✔ Independent read and write clocks  
✔ Gray-code pointer synchronization  
✔ Full and Empty detection  
✔ Almost Full and Almost Empty flags  
✔ Dual-port FIFO memory  
✔ Safe clock domain crossing design  

---

# 🧠 Problem Addressed

When two modules operate on **different clocks**, direct data transfer can lead to:

- Metastability  
- Data corruption  
- Timing hazards  

Asynchronous FIFOs solve this problem by acting as a **buffer between clock domains**.

---

# 🏗 System Architecture

<p align="center">
<img src="docs/system_architecture.png" width="650">
</p>

The architecture contains the following modules:

- Write Pointer Logic
- Read Pointer Logic
- FIFO Memory (Dual-Port)
- Gray Code Pointer Synchronization
- Full & Almost Full Detection
- Empty & Almost Empty Detection

---

# ⚙ Core Modules

## Write Pointer Logic

Maintains the write address inside the **write clock domain**.

Features:

- Binary write pointer
- Gray-code conversion
- Write address generation
- Overflow protection

<p align="center">
<img src="docs/write_pointer.png" width="500">
</p>

---

## Read Pointer Logic

Maintains the read address inside the **read clock domain**.

Features:

- Binary read pointer
- Gray-code conversion
- Safe pointer synchronization
- Underflow protection

<p align="center">
<img src="docs/read_pointer.png" width="500">
</p>

---

## FIFO Memory

The memory block is implemented as a **dual-port memory**.

| Port | Function |
|-----|----------|
| Write Port | Data written using write clock |
| Read Port | Data read using read clock |

Advantages:

- Simultaneous read and write
- Efficient buffering
- Prevents overflow/underflow

---

# 🔄 Gray Code Synchronization

Binary counters can change **multiple bits simultaneously**, which can cause synchronization errors across clock domains.

Gray-code solves this problem because:

✔ Only **one bit changes at a time**  
✔ Reduced metastability risk  
✔ Reliable pointer synchronization  

<p align="center">
<img src="docs/synchronizer.png" width="500">
</p>

Two-stage flip-flop synchronizers are used for safe CDC transfer.

---

# 📊 Full and Almost Full Detection

The FIFO becomes **FULL** when the write pointer catches the read pointer after wrap-around.

### Full Detection Logic

```
Next Gray Write Pointer == Inverted MSB of Read Pointer
```

<p align="center">
<img src="docs/full_logic.png" width="500">
</p>

### Almost Full

Provides early warning before FIFO overflow.

```
Used Entries >= DEPTH - ALMOST_FULL_MARGIN
```

---

# 📉 Empty and Almost Empty Detection

The FIFO becomes **EMPTY** when:

```
Read Pointer == Synchronized Write Pointer
```

<p align="center">
<img src="docs/empty_logic.png" width="500">
</p>

### Almost Empty

Indicates the buffer is close to empty.

```
Used Entries <= ALMOST_EMPTY_MARGIN
```

---

# 🧪 Simulation Results

The FIFO was verified using a **multi-clock testbench**.

### Simulation Waveform

<p align="center">
<img src="images/simulation_output.png" width="750">
</p>

Verified conditions:

✔ Correct data ordering  
✔ Proper flag generation  
✔ Stable clock domain crossing  

---

# 🧩 RTL Schematic

<p align="center">
<img src="images/rtl_schematic.png" width="750">
</p>

The RTL view shows:

- Synchronizer modules  
- FIFO memory block  
- Pointer generation logic  
- Flag detection modules  

---

# 📁 Project Structure

```
Asynchronous-FIFO
│
├── rtl
│   ├── asynchronous_fifo.v
│   ├── sync_w2r.v
│   ├── sync_r2w.v
│   ├── fifo_mem.v
│   ├── full_with_almost.v
│   └── empty_with_almost.v
│
├── testbench
│   └── fifo_tb.v
│
├── docs
│   ├── architecture.png
│   ├── pointer_logic.png
│   └── synchronizer.png
│
├── images
│   ├── simulation_output.png
│   └── rtl_schematic.png
│
└── README.md
```

---

# ⚡ Design Parameters

| Parameter | Description |
|-----------|-------------|
| WIDTH | Data width |
| DEPTH | FIFO depth |
| ALMOST_FULL_MARGIN | Threshold for Almost Full |
| ALMOST_EMPTY_MARGIN | Threshold for Almost Empty |

---

# 💻 Example Verilog Snippet

```verilog
always @(posedge w_clk) begin
 if (wr_rq && !full) begin
  fifo[waddr] <= wdata;
 end
end

always @(posedge r_clk) begin
 if (rd_rq && !empty) begin
  rdata <= fifo[raddr];
 end
end
```

---

# 🎯 Applications

This FIFO can be used in:

- SoC Interconnect Systems
- Communication Interfaces
- Bus Bridges
- Network Routers
- Processor Pipelines
- DMA Controllers

---

# 🔮 Future Improvements

Possible extensions include:

- AXI / AHB FIFO integration
- Formal CDC verification
- FPGA implementation
- ASIC optimization
- Multi-channel FIFO architecture

---

# 👨‍💻 Author

**Raviranjan Kumar**

M.Tech – Embedded System Design  
National Institute of Technology Kurukshetra

---

# ⭐ Support

If you find this project useful, please **⭐ star the repository**.
