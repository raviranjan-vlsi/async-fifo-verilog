# 🔧 Pull Request

Thank you for contributing to the **Parameterized Asynchronous FIFO with Gray-Code Pointers** project! 🚀

Please fill out the following information to help reviewers understand and evaluate your contribution.

---

# 📋 Description

Provide a clear and concise description of the changes in this pull request.

Example:

- Added improvement to Gray-code pointer synchronization
- Fixed bug in almost_full flag generation
- Improved testbench coverage for asynchronous clocks

---

# 🎯 Type of Change

Please check the relevant option(s):

- [ ] 🐞 Bug fix
- [ ] ✨ New feature
- [ ] ⚡ Performance improvement
- [ ] 🔧 Code refactoring
- [ ] 📚 Documentation update
- [ ] 🧪 Testbench improvement
- [ ] 🛠 Build / tooling update

---

# 🧠 Design Area Affected

Select the affected design module(s):

- [ ] Write pointer logic
- [ ] Read pointer logic
- [ ] Gray-code synchronization
- [ ] FIFO memory module
- [ ] Full flag detection
- [ ] Empty flag detection
- [ ] Almost-full logic
- [ ] Almost-empty logic
- [ ] Testbench
- [ ] Documentation

---

# 🧪 Verification / Testing

Explain how the changes were tested.

Example:

- Simulation executed using ModelSim
- Verified FIFO behavior under different clock frequencies
- Checked full/empty and almost-full/almost-empty conditions
- Randomized read/write traffic tested

Simulation tool used:

```
ModelSim / Questa / Vivado / Icarus Verilog
```

---

# 📊 Simulation Results

If applicable, include simulation waveform screenshots or logs.

Example:

```
images/simulation_waveform.png
```

Or paste waveform screenshots below.

---

# 📁 Files Modified

List major files modified in this PR.

Example:

```
rtl/asynchronous_fifo.v
rtl/full_with_almost.v
rtl/empty_with_almost.v
testbench/fifo_tb.v
docs/architecture_diagram.png
```

---

# ⚙ Hardware / Environment (if applicable)

If tested on FPGA or hardware, provide details.

Example:

- FPGA Board: Xilinx Artix-7
- Toolchain: Vivado 2023.1
- Simulation Tool: ModelSim

---

# ✔ Checklist

Please confirm the following before submitting your PR.

- [ ] Code compiles successfully
- [ ] Simulation runs without errors
- [ ] CDC-safe design principles maintained
- [ ] Testbench updated (if needed)
- [ ] Documentation updated (if needed)
- [ ] No unrelated files included

---

# 💬 Additional Notes

Provide any extra context, discussion points, or design decisions.

Example:

- Added parameterization for FIFO depth
- Improved pointer comparison logic

---

# 🙏 Thank You

Thank you for contributing to the **Asynchronous FIFO project** and helping improve reliable **Clock Domain Crossing designs for digital systems**!
