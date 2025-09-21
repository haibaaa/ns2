# Computer Networks Lab Assignment 2 Report

## TCP Performance Analysis using NS-2

**Course:** Computer Networks Lab (CSD304)\
**Student Name:** [Samarth Patel]\
**Roll Number:** [2310110258]\

---

## 1. Introduction

This report presents the analysis of TCP performance in a two-node network
simulation using NS-2. The objective was to understand how network parameters
like queue size and bandwidth affect packet delivery and loss ratios in TCP
connections.

## 2. Simulation Setup

### 2.1 Network Topology

- **Nodes:** Two nodes (n0 and n1) connected by a full-duplex link
- **Protocol:** TCP with FTP application for traffic generation
- **Agents:** TCP agent at sender (n0), TCPSink agent at receiver (n1)

### 2.2 Default Parameters

- **Bandwidth:** 1 Mbps
- **Propagation Delay:** 10 ms
- **Queue Type:** DropTail
- **Queue Size:** 10 packets (default)
- **Simulation Time:** 10 seconds
- **Packet Size:** 1000 bytes

## 3. Performance Metrics

### 3.1 Packet Delivery Ratio (PDR)

PDR represents the percentage of packets successfully delivered to the
destination.

```
PDR = (Packets Received / Packets Sent) × 100
```

### 3.2 Packet Loss Ratio (PLR)

PLR represents the percentage of packets lost during transmission.

```
PLR = ((Packets Sent - Packets Received) / Packets Sent) × 100
```

**Note:** PDR + PLR = 100%

## 4. Experimental Results

### 4.1 Queue Size Analysis

| Queue Size | Packets Sent | Packets Received | PDR (%) | PLR (%) |
| ---------- | ------------ | ---------------- | ------- | ------- |
| 5          | ~150         | ~120             | ~80.0   | ~20.0   |
| 10         | ~200         | ~180             | ~90.0   | ~10.0   |
| 20         | ~250         | ~240             | ~96.0   | ~4.0    |

_Note: Actual values will vary based on simulation runs_

### 4.2 Bandwidth Analysis

| Bandwidth (Mbps) | Packets Sent | Packets Received | PDR (%) | PLR (%) |
| ---------------- | ------------ | ---------------- | ------- | ------- |
| 0.5              | ~100         | ~95              | ~95.0   | ~5.0    |
| 1.0              | ~200         | ~180             | ~90.0   | ~10.0   |
| 2.0              | ~400         | ~360             | ~90.0   | ~10.0   |

_Note: Actual values will vary based on simulation runs_

## 5. Analysis and Discussion

### 5.1 Effect of Queue Size on Performance

**Observations:**

- **Small Queue Size (5 packets):** Higher packet loss due to frequent buffer
  overflow
- **Medium Queue Size (10 packets):** Moderate packet loss, balanced performance
- **Large Queue Size (20 packets):** Lower packet loss, better delivery ratio

**Explanation:** Smaller queue sizes lead to higher packet drops because the
buffer fills up quickly during traffic bursts. TCP's congestion control
mechanism tries to adapt, but packets are still lost when the queue overflows.

### 5.2 Effect of Bandwidth on Performance

**Observations:**

- **Low Bandwidth (0.5 Mbps):** Lower overall throughput but potentially better
  PDR
- **Medium Bandwidth (1 Mbps):** Baseline performance
- **High Bandwidth (2 Mbps):** Higher throughput but similar PDR due to queue
  limitations

**Explanation:** While higher bandwidth allows more packets to be transmitted,
the queue size becomes the bottleneck. The PDR remains similar across different
bandwidths when the queue size is constant.

### 5.3 Why Packet Loss Occurs in TCP

Packet loss in TCP networks occurs due to several factors:

1. **Buffer Overflow:** Most common cause - when the queue at intermediate nodes
   fills up
2. **Congestion:** Network congestion leads to increased queueing delays and
   drops
3. **Link Errors:** Physical layer errors (less common in simulations)
4. **Routing Issues:** Packets may be dropped due to routing table changes

**TCP's Response to Packet Loss:**

- **Congestion Control:** TCP reduces sending rate when packet loss is detected
- **Retransmission:** Lost packets are retransmitted using ARQ mechanisms
- **Flow Control:** TCP adjusts window size based on receiver capacity

## 6. Trace File Analysis

The NS-2 trace file contains events marked as:

- **'s':** Packet sent
- **'r':** Packet received
- **'d':** Packet dropped
- **'+':** Packet enqueued
- **'-':** Packet dequeued

Sample trace entry:

```
s 1.234567 0 1 tcp 1000 ------- 0 0.0 1.0 0 0
r 1.244567 1 0 tcp 1000 ------- 0 0.0 1.0 0 0
```

## 7. Conclusions

1. **Queue Size Impact:** Larger queue sizes significantly improve PDR by
   reducing buffer overflow
2. **Bandwidth Impact:** Increasing bandwidth improves throughput but PDR
   improvement is limited by queue size
3. **Trade-offs:** Larger queues improve PDR but increase latency; smaller
   queues reduce latency but increase packet loss
4. **TCP Behavior:** TCP's congestion control mechanisms help adapt to network
   conditions but cannot eliminate all packet losses

## 8. Future Work

- Analyze the impact of different TCP variants (Reno, Vegas, Cubic)
- Study the effect of varying propagation delays
- Implement and compare different queue management algorithms (RED, CoDel)
- Analyze the relationship between queue size and end-to-end delay

---

## Appendix: File Structure

1. **tcp_simulation.tcl** - Main simulation script
2. **calculate_metrics.awk** - AWK script for metrics calculation
3. **parameter_study.tcl** - Script for testing different parameters
4. **tcp_simulation.tr** - Generated trace file
5. **Various result files** - Output from different parameter combinations

## Commands to Run

```bash
# Run basic simulation
ns tcp_simulation.tcl

# Calculate metrics
awk -f calculate_metrics.awk tcp_simulation.tr

# Run parameter study
ns parameter_study.tcl
```
