# 📦 Parameterized Synchronous FIFO Design in Verilog

<p align="center">

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Domain](https://img.shields.io/badge/Domain-VLSI-orange)
![FIFO](https://img.shields.io/badge/Design-Synchronous%20FIFO-green)
![RTL](https://img.shields.io/badge/Type-RTL%20Design-purple)
![License](https://img.shields.io/badge/License-MIT-brightgreen)

</p>

---

# 🚀 Overview

This project implements a **Parameterized Synchronous FIFO (First-In First-Out)** buffer using **Verilog HDL**.

The FIFO is designed for **single clock domain operation**, where both read and write operations are controlled using the same clock signal.

The design supports:

✔ Configurable FIFO depth  
✔ Configurable data width  
✔ Full and Empty flag generation  
✔ Simultaneous read/write operations  
✔ Efficient memory management  
✔ RTL-based scalable architecture  

The project demonstrates a reusable FIFO architecture suitable for:

- Digital systems
- SoC designs
- Communication interfaces
- FPGA-based systems

---

# 🎯 Key Features

✅ Single clock operation  
✅ Parameterized FIFO architecture  
✅ Full flag generation  
✅ Empty flag generation  
✅ Read and write pointer logic  
✅ FIFO memory array  
✅ Overflow and underflow protection  
✅ Synthesizable RTL design  

---

# 🧠 FIFO Concept

A **FIFO (First-In First-Out)** is a memory structure where:

- The **first data written** is the **first data read**
- Data is stored sequentially
- Read and write operations use pointer management

### FIFO Operation

```text
Write → FIFO Memory → Read
```

---

# 🏗 System Architecture

<p align="center">
<img src="docs/system_architecture.png" width="650">
</p>

The synchronous FIFO contains:

- FIFO Memory
- Write Pointer Logic
- Read Pointer Logic
- Full Detection Logic
- Empty Detection Logic
- Control Logic

---

# ⚙ Core Components

## 📝 Write Pointer Logic

The write pointer tracks the location where new data will be written.

Features:

- Incremented during write operation
- Stops incrementing when FIFO is FULL
- Prevents overflow condition

<p align="center">
<img src="docs/write_pointer.png" width="500">
</p>

---

## 📖 Read Pointer Logic

The read pointer tracks the location from where data will be read.

Features:

- Incremented during read operation
- Stops incrementing when FIFO is EMPTY
- Prevents underflow condition

<p align="center">
<img src="docs/read_pointer.png" width="500">
</p>

---

## 💾 FIFO Memory

The FIFO memory stores incoming data sequentially.

```verilog
reg [WIDTH-1:0] fifo [0:DEPTH-1];
```

Features:

✔ Parameterized memory depth  
✔ Efficient storage mechanism  
✔ Synthesizable design  

---

# 📊 Full and Empty Flag Logic

## 🚫 Full Condition

FIFO becomes FULL when:

```text
(write_pointer + 1) == read_pointer
```

<p align="center">
<img src="docs/full_flag.png" width="450">
</p>

---

## 📭 Empty Condition

FIFO becomes EMPTY when:

```text
write_pointer == read_pointer
```

<p align="center">
<img src="docs/empty_flag.png" width="450">
</p>

---

# 🧪 Simulation Results

The design was verified using a Verilog testbench.

### Simulation Waveform

<p align="center">
<img src="images/simulation_waveform.png" width="750">
</p>

Simulation verifies:

✔ Correct FIFO ordering  
✔ Full flag assertion  
✔ Empty flag assertion  
✔ Proper read/write operation  

---

# 🧩 RTL Schematic

<p align="center">
<img src="images/rtl_schematic.png" width="750">
</p>

The RTL schematic shows:

- FIFO memory block
- Pointer logic
- Control logic
- Flag generation circuitry

---

# 📁 Project Structure

```text
Synchronous-FIFO
│
├── rtl
│   ├── synchronous_fifo.v
│   └── fifo_memory.v
│
├── testbench
│   └── fifo_tb.v
│
├── docs
│   ├── system_architecture.png
│   ├── write_pointer.png
│   ├── read_pointer.png
│   ├── full_flag.png
│   └── empty_flag.png
│
├── images
│   ├── simulation_waveform.png
│   └── rtl_schematic.png
│
└── README.md
```

---

# ⚡ Parameters

| Parameter | Description |
|-----------|-------------|
| WIDTH | Data width |
| DEPTH | FIFO depth |

Example:

```verilog
parameter WIDTH = 8;
parameter DEPTH = 16;
```

---

# 💻 Example Verilog Snippet

```verilog
always @(posedge clk)
begin
    if(wr_en && !full)
    begin
        fifo[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
    end
end

always @(posedge clk)
begin
    if(rd_en && !empty)
    begin
        data_out <= fifo[rd_ptr];
        rd_ptr <= rd_ptr + 1;
    end
end
```

---

# 🛠 Simulation

## Using ModelSim

```bash
vlog synchronous_fifo.v fifo_tb.v
vsim fifo_tb
run -all
```

---

# 🎯 Applications

This FIFO design can be used in:

- Processor pipelines
- UART communication
- DMA controllers
- FPGA systems
- Buffer management systems
- Digital communication systems

---

# 🔮 Future Improvements

Possible future enhancements:

- Almost full / almost empty flags
- AXI Stream FIFO support
- Burst transaction support
- Error correction mechanisms
- FPGA optimization

---

# 📚 Concepts Used

- RTL Design
- FIFO Architecture
- Pointer Management
- Digital Memory Systems
- Verilog HDL
- Synchronous Design

---

# 👨‍💻 Author

**Raviranjan Kumar**

🎓 M.Tech – Embedded System Design  
🏫 National Institute of Technology Kurukshetra  

---

# ⭐ Support

If you found this project useful, please ⭐ star the repository.
