# simulator setup
set ns [new Simulator]

set tracefile [open out.tr w]
$ns trace-all $tracefile

set namfile [open out.nam w]
$ns namtrace-all $namfile

set val(stop) 10.0

# node setup
set n0 [$ns node]
$n0 label "src1"

set n1 [$ns node]
$n1 label "dest1"
$n1 shape square

set n2 [$ns node]
$n2 label "src2"

set n3 [$ns node]
$n3 label "dest2"
$n3 shape square

# lan setup
$ns make-lan "$n0 $n1 $n2 $n3" 50.0Mb 10ms LL Queue/DropTail Mac/802_3

# tcp setup 
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1

set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0

set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1

$ns connect $tcp0 $sink0
$ns connect $tcp1 $sink1

# ftp setup
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 2.0 "$ftp0 stop"

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 3.0 "$ftp1 start"
$ns at 4.0 "$ftp1 stop"

set one [open one.tr w]
$tcp0 attach $one

set two [open two.tr w]
$tcp1 attach $two

$tcp0 trace cwnd_
$tcp1 trace cwnd_

# termination
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
