#!/bin/bash

check_cpu() {
echo "--- CPU ---"
top -b -n 1 | head -n 10
}

check_memory() {
echo "--- Memory ---"
free -m
}

check_disk() {
echo "--- Disk ---"
df -h
}

check_process() {
echo "--- Processes ---"
ps aux --sort=-%cpu | head -n 10 
}

check_cpu
check_memory
check_disk
check_process
