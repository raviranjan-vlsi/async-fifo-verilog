# 🤝 Contributing to Parameterized Asynchronous FIFO

First off, thank you for considering contributing to this project! 🎉  
This repository implements a **Parameterized Asynchronous FIFO using Gray-Code Pointers with Almost Full and Almost Empty flags** for reliable **Clock Domain Crossing (CDC)** in digital systems.

Contributions that improve the **design quality, verification coverage, documentation, or usability** are welcome.

---

# 📌 Table of Contents

- Ways to Contribute
- Getting Started
- Development Workflow
- Coding Guidelines
- RTL Design Guidelines
- Simulation Guidelines
- Documentation Guidelines
- Commit Message Guidelines
- Pull Request Process
- Reporting Issues
- Code of Conduct

---

# 🚀 Ways to Contribute

You can contribute in multiple ways:

### 🧠 RTL Design Improvements
- Optimize FIFO architecture
- Improve pointer synchronization
- Add advanced CDC safety mechanisms
- Improve parameterization

### 🧪 Verification & Testing
- Improve testbench coverage
- Add randomized tests
- Add assertions
- Improve simulation outputs

### 📊 Documentation
- Improve README
- Add design diagrams
- Add waveform explanations
- Improve architecture documentation

### ⚙ Tool Support
- Add scripts for simulation
- Add FPGA implementation flow
- Add synthesis reports

---

# 🛠 Getting Started

### 1️⃣ Fork the Repository

Click **Fork** in the top-right corner of the repository.

---

### 2️⃣ Clone Your Fork

```bash
git clone https://github.com/your-username/asynchronous-fifo.git
cd asynchronous-fifo
```

---

### 3️⃣ Create a Branch

Create a new branch for your feature or fix.

```bash
git checkout -b feature/new-feature
```

Example:

```bash
git checkout -b feature/improve-gray-pointer-sync
```

---

# 🔄 Development Workflow

1. Fork repository  
2. Clone your fork  
3. Create a feature branch  
4. Implement changes  
5. Test your changes  
6. Commit updates  
7. Push changes  
8. Submit Pull Request  

---

# 💻 Coding Guidelines

### General

- Use **clean and readable Verilog code**
- Follow **consistent indentation**
- Use **meaningful signal names**
- Avoid unnecessary logic duplication

### Naming Convention

| Type | Example |
|-----|--------|
| Module | `async_fifo` |
| Register | `wr_ptr` |
| Wire | `sync_rd_ptr` |
| Parameter | `FIFO_DEPTH` |

---

# 🧠 RTL Design Guidelines

Follow best practices for **CDC-safe RTL design**.

### Pointer Synchronization

- Use **Gray-code pointers**
- Avoid direct binary pointer transfer across domains

### Synchronization

Always use **two-stage synchronizers**:

```verilog
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        sync_ptr <= 0;
    else
        sync_ptr <= ptr;
end
```

### Avoid

❌ Combinational CDC paths  
❌ Unsynchronized multi-bit transfers  
❌ Asynchronous feedback loops

---

# 🧪 Simulation Guidelines

Before submitting a PR:

✔ Ensure testbench runs without errors  
✔ Verify FIFO full/empty behavior  
✔ Check almost-full and almost-empty flags  
✔ Validate read/write clock independence  

Recommended simulators:

- ModelSim
- QuestaSim
- Vivado Simulator
- Icarus Verilog

Example run command:

```bash
iverilog fifo_tb.v asynchronous_fifo.v -o fifo_sim
vvp fifo_sim
```

---

# 📊 Documentation Guidelines

When contributing documentation:

- Use **Markdown formatting**
- Add diagrams when possible
- Include waveform screenshots
- Explain CDC logic clearly

Recommended diagrams:

- FIFO architecture
- Pointer synchronization
- Flag generation logic

---

# 📝 Commit Message Guidelines

Use clear commit messages.

Example format:

```
type(scope): description
```

Examples:

```
feat(rtl): add almost full detection logic
fix(sync): correct pointer synchronization bug
docs(readme): update architecture diagram
test(tb): improve randomized test coverage
```

---

# 🔀 Pull Request Process

1️⃣ Ensure your branch is up to date with `main`

```bash
git pull origin main
```

2️⃣ Push your branch

```bash
git push origin feature-name
```

3️⃣ Open a Pull Request

Provide:

- Description of changes
- Reason for change
- Simulation results (if applicable)
- Screenshots or waveforms

---

# 🐛 Reporting Issues

If you find a bug or issue, open a **GitHub Issue** and include:

- Problem description
- Steps to reproduce
- Simulation logs
- Expected behavior
- Actual behavior

Example:

```
Issue: FIFO almost_empty flag triggers too early
Simulator: ModelSim
Version: v1.0
```

---

# 📁 Project Structure

```
asynchronous-fifo
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
│   └── architecture_diagram.png
│
├── images
│   ├── simulation_waveform.png
│   └── rtl_schematic.png
│
└── README.md
```

---

# 📜 Code of Conduct

Please be respectful and collaborative when contributing.

We encourage:

- constructive feedback
- open discussion
- collaborative improvements

---

# ⭐ Acknowledgment

Thank you for helping improve this project!  
Contributions help make this **asynchronous FIFO implementation more reliable and educational for the VLSI community**.

Happy Coding 🚀
