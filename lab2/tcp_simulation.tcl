# NS-2 TCP Simulation Script
# Two-node network with TCP/FTP traffic
# Author: Generated for CN Lab Assignment

# Create a new simulator object
set ns [new Simulator]

# Open trace file for output
set tracefile [open "tcp_simulation.tr" w]
$ns trace-all $tracefile

# Open NAM file for visualization (optional)
set namfile [open "tcp_simulation.nam" w]
$ns namtrace-all $namfile

# Create two nodes
set n0 [$ns node]
set n1 [$ns node]

# Create a duplex link between the nodes
# Parameters: bandwidth=1Mb, delay=10ms, queue=DropTail
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

# Set queue limit to cause packet drops
$ns queue-limit $n0 $n1 10

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

# Set TCP parameters (optional - for better results)
$tcp set class_ 2
$tcp set window_ 20
$tcp set packetSize_ 1000

# Schedule events
$ns at 0.1 "$ftp start"
$ns at 9.9 "$ftp stop"

# Define finish procedure
proc finish {} {
    global ns tracefile namfile
    
    # Close trace and nam files
    $ns flush-trace
    close $tracefile
    close $namfile
    
    # Calculate PDR and PLR using AWK
    puts "Simulation completed. Calculating PDR and PLR..."
    exec awk -f calculate_metrics.awk tcp_simulation.tr
    
    exit 0
}

# Schedule simulation end
$ns at 10.0 "finish"

# Print simulation start message
puts "Starting TCP simulation..."
puts "Simulation parameters:"
puts "- Bandwidth: 1 Mbps"
puts "- Delay: 10 ms"
puts "- Queue size: 10 packets"
puts "- Simulation time: 10 seconds"

# Run the simulation
$ns run
