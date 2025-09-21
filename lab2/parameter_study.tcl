# NS-2 Parameter Study Script
# Tests different queue sizes and bandwidths
# Author: Generated for CN Lab Assignment

proc run_simulation {bandwidth delay queue_size output_prefix} {
    # Create a new simulator object
    set ns [new Simulator]
    
    # Open trace file for output
    set tracefile [open "${output_prefix}_trace.tr" w]
    $ns trace-all $tracefile
    
    # Create two nodes
    set n0 [$ns node]
    set n1 [$ns node]
    
    # Create a duplex link between the nodes
    $ns duplex-link $n0 $n1 ${bandwidth}Mb ${delay}ms DropTail
    
    # Set queue limit
    $ns queue-limit $n0 $n1 $queue_size
    
    # Create TCP agent and attach to node n0 (sender)
    set tcp [new Agent/TCP]
    $ns attach-agent $n0 $tcp
    
    # Create TCP Sink agent and attach to node n1 (receiver)
    set sink [new Agent/TCPSink]
    $ns attach-agent $n1 $sink
    
    # Connect TCP agent to TCP Sink
    $ns connect $tcp $sink
    
    # Create FTP application and attach to TCP agent
    set ftp [new Application/FTP]
    $ftp attach-agent $tcp
    
    # Set TCP parameters
    $tcp set class_ 2
    $tcp set window_ 20
    $tcp set packetSize_ 1000
    
    # Schedule events
    $ns at 0.1 "$ftp start"
    $ns at 9.9 "$ftp stop"
    
    # Define finish procedure
    proc finish {} {
        global ns tracefile
        $ns flush-trace
        close $tracefile
    }
    
    # Schedule simulation end
    $ns at 10.0 "finish"
    
    # Run the simulation
    $ns run
}

# Main execution
puts "=== Parameter Study for TCP Performance ==="
puts "Testing different queue sizes and bandwidths...\n"

# Test different queue sizes with 1Mb bandwidth
set queue_sizes {5 10 20}
foreach q $queue_sizes {
    puts "Running simulation: Bandwidth=1Mb, Queue Size=$q"
    run_simulation 1 10 $q "queue_${q}"
    
    # Calculate metrics for this run
    puts "Calculating metrics for queue size $q..."
    exec awk -f calculate_metrics.awk "queue_${q}_trace.tr" > "queue_${q}_results.txt"
    puts "Results saved to queue_${q}_results.txt\n"
}

# Test different bandwidths with queue size 10
set bandwidths {0.5 1 2}
foreach bw $bandwidths {
    puts "Running simulation: Bandwidth=${bw}Mb, Queue Size=10"
    run_simulation $bw 10 10 "bw_${bw}"
    
    # Calculate metrics for this run
    puts "Calculating metrics for bandwidth ${bw}Mb..."
    exec awk -f calculate_metrics.awk "bw_${bw}_trace.tr" > "bw_${bw}_results.txt"
    puts "Results saved to bw_${bw}_results.txt\n"
}

puts "Parameter study completed!"
puts "Check individual result files for detailed analysis."
