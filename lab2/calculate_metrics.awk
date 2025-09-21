# AWK script to calculate PDR and PLR from NS-2 trace file
# Usage: awk -f calculate_metrics.awk trace_file.tr

BEGIN {
    sent_packets = 0
    received_packets = 0
    dropped_packets = 0
    
    print "=== TCP Performance Analysis ==="
    print "Analyzing trace file..."
}

{
    # Trace file format: event time from_node to_node pkt_type pkt_size flags fid src_addr dest_addr seq_num pkt_id
    
    event = $1      # Event type: s (sent), r (received), d (dropped), + (enqueued), - (dequeued)
    time = $2       # Time of event
    from_node = $3  # Source node
    to_node = $4    # Destination node
    pkt_type = $5   # Packet type (tcp, ack, etc.)
    pkt_size = $6   # Packet size
    
    # Count TCP data packets sent from node 0
    if (event == "s" && from_node == "0" && pkt_type == "tcp") {
        sent_packets++
    }
    
    # Count TCP data packets received at node 1
    if (event == "r" && to_node == "1" && pkt_type == "tcp") {
        received_packets++
    }
    
    # Count dropped packets
    if (event == "d" && pkt_type == "tcp") {
        dropped_packets++
    }
}

END {
    print "\n=== SIMULATION RESULTS ==="
    print "Packets Sent =", sent_packets
    print "Packets Received =", received_packets
    print "Packets Dropped =", dropped_packets
    
    if (sent_packets > 0) {
        pdr = (received_packets / sent_packets) * 100
        plr = ((sent_packets - received_packets) / sent_packets) * 100
        
        printf "PDR = %.2f%%\n", pdr
        printf "PLR = %.2f%%\n", plr
    } else {
        print "PDR = 0.00%"
        print "PLR = 0.00%"
        print "Warning: No packets were sent!"
    }
    
    print "\n=== ANALYSIS ==="
    printf "Packet Delivery Ratio: %.2f%% of packets reached destination\n", pdr
    printf "Packet Loss Ratio: %.2f%% of packets were lost\n", plr
    
    if (plr > 0) {
        print "Packet loss occurred due to:"
        print "- Queue overflow (queue size = 10 packets)"
        print "- Network congestion"
        print "- TCP congestion control mechanisms"
    }
}
