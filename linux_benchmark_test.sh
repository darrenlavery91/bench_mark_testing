#!/bin/bash
#apt install stress-ng -y
#apt install sysbench -y

# Function to display a loading bar
loading_bar() {
    local duration=$1
    local bar_length=50
    local increment=$((duration / bar_length))
    local i=0

    echo -n "["
    while [ $i -le $bar_length ]; do
        sleep $increment
        echo -n "#"
        i=$((i + 1))
        echo -ne "] $((i * 2))% complete\r"
    done
    echo -ne "\n" # Move to the next line after completion
}

# Function to run a command with a loading bar
run_with_loading_bar() {
    local command=$1
    local duration=$2

    loading_bar $duration & # Start loading bar in the background
    eval $command # Run the command
    wait # Wait for the loading bar to finish
}

echo "========================" >> memory_report.txt
echo "Hostname info"
hostname >> memory_report.txt
echo "========================" >> memory_report.txt

# Initialize the report file
echo "Proxmox Host Memory Test"
echo "Proxmox Host Memory Test" > memory_report.txt
echo "========================" >> memory_report.txt

# Basic Memory Benchmark Test
echo "Basic Memory Benchmark Test"
echo "Basic Memory Benchmark Test" >> memory_report.txt
echo "========================" >> memory_report.txt
loading_bar 10 & # Start loading bar in the background
sysbench --memory-block-size=1M --memory-total-size=10G run >> memory_report.txt
wait # Wait for the loading bar to finish
echo "" >> memory_report.txt

# Intermediate Memory Benchmark Test
echo "Intermediate Memory Benchmark Test"
echo "Intermediate Memory Benchmark Test" >> memory_report.txt
echo "========================" >> memory_report.txt
loading_bar 10 & # Start loading bar in the background
sysbench --memory-block-size=4M --memory-total-size=10G run >> memory_report.txt
wait # Wait for the loading bar to finish
echo "" >> memory_report.txt

# Advanced Memory Benchmark Test
echo "Advanced Memory Benchmark Test"
echo "Advanced Memory Benchmark Test" >> memory_report.txt
echo "========================" >> memory_report.txt
loading_bar 10 & # Start loading bar in the background
sysbench --memory-block-size=8M --memory-total-size=10G --threads=4 run >> memory_report.txt
wait # Wait for the loading bar to finish
echo "" >> memory_report.txt

# Uncomment to test VMs
# # VM Memory Test
# echo "VM Memory Test" >> memory_report.txt
# echo "===============" >> memory_report.txt
# for vm in $(qm list | awk 'NR>1 {print $1}'); do
#     echo "Running test on VM ID $vm..." >> memory_report.txt
#     pct exec $vm -- sysbench --test=memory --memory-block-size=1M --memory-total-size=10G run >> memory_report.txt
#     echo "===================" >> memory_report.txt
# done

echo "" >> memory_report.txt

# Basic Stress Test on Host
echo "Basic Stress Test on Host"
echo "Basic Stress Test on Host" >> memory_report.txt
echo "========================" >> memory_report.txt
loading_bar 60 & # Start loading bar in the background
stress-ng --vm 2 --vm-bytes 2G --timeout 60s --metrics-brief >> memory_report.txt 2>&1
wait # Wait for the loading bar to finish
echo "" >> memory_report.txt

# Intermediate Stress Test on Host
echo "Intermediate Stress Test on Host"
echo "Intermediate Stress Test on Host" >> memory_report.txt
echo "=============================" >> memory_report.txt
loading_bar 60 & # Start loading bar in the background
stress-ng --vm 4 --vm-bytes 4G --timeout 60s --metrics-brief >> memory_report.txt 2>&1
wait # Wait for the loading bar to finish
echo "" >> memory_report.txt

# Advanced Stress Test on Host
echo "Advanced Stress Test on Host"
echo "Advanced Stress Test on Host" >> memory_report.txt
echo "=============================" >> memory_report.txt
loading_bar 60 & # Start loading bar in the background
stress-ng --vm 8 --vm-bytes 8G --timeout 60s --metrics-brief --metrics >> memory_report.txt 2>&1
wait # Wait for the loading bar to finish
echo "" >> memory_report.txt

# Huge Pages info
echo "Huge Pages info" >> memory_report.txt
echo "=============================================" >> memory_report.txt
grep Huge /proc/meminfo >> memory_report.txt

echo "Report saved in memory_report.txt"
