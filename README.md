# Linux Resource Checker

A simple Bash script to check CPU, memory, disk usage, and top running processes on a Linux server. Originally built and tested on an AWS EC2 instance / Proxmox environment.

## What it does

Running the script prints four sections:

- **CPU** — snapshot from `top` (batch mode, single iteration, trimmed to the summary lines)
- **Memory** — output from `free -m`
- **Disk** — output from `df -h`
- **Processes** — top 10 processes sorted by CPU usage

## Requirements

- A Linux system (tested on Ubuntu / EC2). This script relies on GNU tools (`top -b`, `free`, `ps --sort`) that aren't available on macOS/BSD systems.

## Usage

Make the script executable:

```bash
chmod +x resources.sh
```

Run it directly to see output on screen:

```bash
./resources.sh
```

Or capture the latest snapshot to a file (overwrites each time):

```bash
./resources.sh > output.txt
```

## Example output

```
--- CPU ---
top - 22:03:13 up 58 days,  6:11,  1 user,  load average: 0.00, 0.00, 0.00
Tasks: 121 total,   1 running, 120 sleeping,   0 stopped,   0 zombie
%Cpu(s):  4.3 us,  0.0 sy,  0.0 ni, 91.3 id,  4.3 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :    908.7 total,    269.3 free,    348.1 used,    415.1 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.    560.6 avail Mem

--- Memory ---
              total        used        free      shared  buff/cache   available
Mem:            908         348         269           2         415         560
Swap:             0           0           0

--- Disk ---
Filesystem       Size  Used Avail Use% Mounted on
/dev/root        6.7G  2.9G  3.8G  44% /
...

--- Processes ---
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
...
```

## Notes

- CPU output is piped through `head` to trim the full process table down to the summary lines, since the top processes are already covered separately by the Processes section.
- The script overwrites its output each run rather than appending — it's meant to give a quick current snapshot, not a running log.

## Possible future improvements

- Wrap the function calls in a `main` function
- Add a timestamp to each run
- Add threshold-based alerts (e.g., warn if disk usage > 90%)
