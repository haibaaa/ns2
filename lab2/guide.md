# NS-2 Lab Setup Guide

## Computer Networks Lab Assignment 2

**TCP Performance Analysis using NS-2**

Dr. Himani Sikarwar\
Shiv Nadar Institution of Eminence

<!--end_slide-->

# Prerequisites Checklist ✅

Before your lab session (22/09 or 24/09):

- 💻 NS-2 installed and working
- 📁 All script files saved
- 🔧 Basic Linux/Unix commands knowledge
- 📚 Understanding of TCP concepts
- ⚡ System ready for simulation

**Important**: Incomplete setup = marks deduction!

<!--end_slide-->

# Installing NS-2 🛠️

## Method 1: Package Manager (Recommended)

```bash
sudo apt-get update
sudo apt-get install ns2 nam xgraph
```

## Method 2: From Source

```bash
wget https://sourceforge.net/projects/nsnam/files/\
allinone/ns-allinone-2.35/ns-allinone-2.35.tar.gz
tar -xzf ns-allinone-2.35.tar.gz
cd ns-allinone-2.35
./install
```

<!--end_slide-->

# Verify Installation ✔️

## Test NS-2 Installation:

```bash
ns
```

**Expected Output:**

```
%
```

(TCL prompt appears)

Type `exit` to quit

## Test NAM (Network Animator):

```bash
nam
```

Should open the NAM GUI window

<!--end_slide-->

# File Setup 📂

## Create Working Directory:

```bash
mkdir ~/cn_lab_assignment2
cd ~/cn_lab_assignment2
```

## Required Files:

1. `tcp_simulation.tcl` - Main simulation script
2. `calculate_metrics.awk` - Metrics calculator
3. `parameter_study.tcl` - Parameter analysis
4. Lab report document

**Save all files in the working directory!**

<!--end_slide-->

# Running the Simulation 🚀

## Step 1: Basic Simulation

```bash
ns tcp_simulation.tcl
```

**Generated Files:**

- `tcp_simulation.tr` - Trace file
- `tcp_simulation.nam` - Animation file

## Step 2: Calculate Metrics

```bash
awk -f calculate_metrics.awk tcp_simulation.tr
```

<!--end_slide-->

# Expected Output 📊

```
=== TCP Performance Analysis ===
Analyzing trace file...

=== SIMULATION RESULTS ===
Packets Sent = 234
Packets Received = 210
Packets Dropped = 24
PDR = 89.74%
PLR = 10.26%

=== ANALYSIS ===
Packet Delivery Ratio: 89.74% of packets reached destination
Packet Loss Ratio: 10.26% of packets were lost
```

<!--end_slide-->

# Parameter Study 🔬

## Test Different Configurations:

```bash
ns parameter_study.tcl
```

## This Tests:

- **Queue Sizes:** 5, 10, 20 packets
- **Bandwidths:** 0.5, 1, 2 Mbps

## Results Files Generated:

- `queue_5_results.txt`
- `queue_10_results.txt`
- `bw_0.5_results.txt`
- etc.

<!--end_slide-->

# Troubleshooting 🔧

## Common Issues:

**❌ "ns: command not found"**

- Solution: Install NS-2 or fix PATH

**❌ "Permission denied" for AWK**

- Solution: `chmod +x calculate_metrics.awk`

**❌ No trace file generated**

- Check simulation runs without errors
- Verify directory permissions

<!--end_slide-->

# Debugging Tips 🐛

## Check Trace File:

```bash
head -20 tcp_simulation.tr
```

## Log Simulation Output:

```bash
ns tcp_simulation.tcl 2>&1 | tee simulation.log
```

## Test AWK Script:

```bash
awk -f calculate_metrics.awk tcp_simulation.tr > results.txt
```

<!--end_slide-->

# Trace File Format 📝

## Event Types:

- **s** - Packet sent
- **r** - Packet received
- **d** - Packet dropped
- **+** - Packet enqueued
- **-** - Packet dequeued

## Sample Entry:

```
s 1.234567 0 1 tcp 1000 ------- 0 0.0 1.0 0 0
```

_time=1.234567, from node 0 to 1, TCP packet, 1000 bytes_

<!--end_slide-->

# Viva Preparation 🎓

## Key Concepts to Understand:

**TCP Behavior:**

- Congestion control mechanisms
- Flow control and window management
- Retransmission strategies

**Network Performance:**

- PDR vs PLR relationship
- Queue management impact
- Bandwidth vs queue size effects

<!--end_slide-->

# Sample Viva Questions 💭

1. **What happens when queue size is reduced?**
   - More packet drops due to buffer overflow

2. **How does TCP handle packet loss?**
   - Congestion control, retransmission, window adjustment

3. **Explain trace file entries**
   - Event types, timing, packet flow

4. **Why doesn't bandwidth always improve PDR?**
   - Queue size becomes the bottleneck

<!--end_slide-->

# Lab Day Checklist ✅

Before entering the lab:

- [ ] NS-2 installed and tested
- [ ] All script files ready
- [ ] Simulation runs successfully
- [ ] Metrics calculator works
- [ ] Results generated and analyzed
- [ ] Report completed
- [ ] Concepts understood
- [ ] Files backed up

<!--end_slide-->

# Quick Commands Reference 🚀

```bash
# Setup
mkdir ~/cn_lab_assignment2
cd ~/cn_lab_assignment2

# Run simulation
ns tcp_simulation.tcl

# Calculate metrics
awk -f calculate_metrics.awk tcp_simulation.tr

# Parameter study
ns parameter_study.tcl

# Check results
ls -la *.txt *.tr
```

<!--end_slide-->

# Success Tips 🌟

## During Lab Evaluation:

1. **Be Prepared** - Have everything ready
2. **Understand Code** - Don't just copy-paste
3. **Explain Results** - Know what PDR/PLR mean
4. **Demo Live** - Show simulation running
5. **Answer Confidently** - Practice viva questions

**Remember**: Understanding > Memorization

<!--end_slide-->

# Resources & Support 📚

## Official Documentation:

- NS-2 Manual: https://www.isi.edu/nsnam/ns/doc/
- TCP/IP Illustrated (textbook)
- AWK Programming Guide

## Lab Support:

- **TAs:** Sanghamitra (ss249@snu.edu.in), Vishal (vi921@snu.edu.in)
- **Instructor:** Dr. Himani Sikarwar

## Backup Plan:

Save all files to USB/cloud before lab!

<!--end_slide-->

# Thank You! 🎉

## Ready for Lab Success?

**Lab Dates:**

- Monday Batch: 22/09/2025
- Wednesday Batch: 24/09/2025

**Remember:** Preparation is key to success!

Good luck with your TCP simulation analysis! 🚀
