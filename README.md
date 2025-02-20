---

# Memory Benchmark and Stress Test Scripts

## Overview
This repository contains two scripts for benchmarking and stress-testing the memory of **Linux (Proxmox)** and **Windows** systems. Both scripts generate a detailed report of memory performance, stress the system under different loads, and save the results to a report file.

### Scripts Included:
1. `linux_benchmark_test.sh` (Linux/Proxmox)
2. `windows_benchmark_test.ps1` (Windows)

## Prerequisites

### Linux (Proxmox) Script
The Linux script uses `sysbench` and `stress-ng` for memory benchmarking and stress testing.

**Required Packages:**
- `sysbench`
- `stress-ng`

You can install these packages by running:

```bash
sudo apt update
sudo apt install sysbench stress-ng -y
```

### Windows Script
The Windows script uses `winsat` (built into Windows) for memory benchmarking and `stress` (from Sysinternals or via Chocolatey) for stress testing.

**Required Tools:**
- `winsat` (Pre-installed on Windows)
- `stress` (Can be installed via Chocolatey)

To install Chocolatey and `stress`:
1. Open a PowerShell window **as Administrator**.
2. Install Chocolatey:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; `
   [System.Net.ServicePointManager]::SecurityProtocol = `
   [System.Net.ServicePointManager]::SecurityProtocol `
   -bor 3072; Invoke-Expression `
   ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```
3. Install `stress` via Chocolatey:
   ```powershell
   choco install stress -y
   ```

---

## Usage

### Linux (Proxmox) Script

1. **Clone the Repository or Download the Script**:
   Download the `linux_benchmark_test.sh` script to your desired location.

2. **Make the Script Executable**:
   ```bash
   chmod +x linux_benchmark_test.sh
   ```

3. **Run the Script**:
   Run the script in a terminal with elevated privileges:
   ```bash
   sudo ./linux_benchmark_test.sh
   ```

4. **Report**:
   The script will run memory benchmarks and stress tests, generating a report saved in `memory_report.txt` in the current directory. The report includes the following sections:
   - Basic, Intermediate, and Advanced memory benchmark tests
   - Basic, Intermediate, and Advanced stress tests using `stress-ng`
   - Huge pages information (from `/proc/meminfo`)

---

### Windows Script

1. **Clone the Repository or Download the Script**:
   Download the `windows_benchmark_test.ps1` script to your desired location.

2. **Run the Script**:
   Run the script in **PowerShell as Administrator**:
   ```powershell
   .\windows_benchmark_test.ps1
   ```

3. **Report**:
   The script will perform memory benchmark tests using `winsat` and stress tests using `stress.exe`. The results are saved in `C:\memory_report.txt`. The report includes:
   - Basic, Intermediate, and Advanced memory benchmark tests
   - Basic, Intermediate, and Advanced stress tests using the `stress` tool
   - Huge pages information gathered from the system

---

## Customization

### Linux (Proxmox) Script

- **Benchmark Parameters**: You can modify the `sysbench` memory test parameters such as block size and total memory size directly in the script.
- **Stress Test Parameters**: You can adjust the `stress-ng` parameters to modify the number of virtual memory workers or the amount of memory allocated during the test.

### Windows Script

- **Stress Test Parameters**: The `stress.exe` parameters (number of CPU cores and timeout) can be adjusted within the script to customize the stress test's intensity.
- **Memory Benchmarking**: The script uses `winsat mem` for memory benchmarking. You can add additional parameters to this command if needed.

---

## Example Output

### Linux Output Example (memory_report.txt):
```
========================
Hostname info
=================
proxmox-server
========================

Proxmox Host Memory Test
========================

Basic Memory Benchmark Test
========================
Running sysbench with 1M block size and 10GB total size...

Intermediate Memory Benchmark Test
========================
Running sysbench with 4M block size and 10GB total size...

Advanced Memory Benchmark Test
========================
Running sysbench with 8M block size, 10GB total size, and 4 threads...

Basic Stress Test on Host
========================
Running stress-ng with 2 workers and 2GB memory for 60 seconds...

Huge Pages Info
========================
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     2048 kB
```

### Windows Output Example (C:\memory_report.txt):
```
========================
Hostname info
=================
WIN-SERVER
========================

Basic Memory Benchmark Test
========================
Running winsat mem for basic memory test...

Intermediate Memory Benchmark Test
========================
Running winsat mem for intermediate memory test...

Advanced Memory Benchmark Test
========================
Running winsat mem for advanced memory test...

Basic Stress Test on Host
========================
Running stress.exe with 2 CPU cores for 60 seconds...

Huge Pages Info
========================
TotalVisibleMemorySize: 16777216 KB
```

---

## Troubleshooting

### Linux
- **Permission Issues**: Ensure you run the script with `sudo` to avoid permission issues.
- **Missing Dependencies**: Make sure `sysbench` and `stress-ng` are installed before running the script.

### Windows
- **PowerShell Execution Policy**: If you encounter an error about script execution policies, run the following command in PowerShell before executing the script:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope Process
  ```

---

## Contributing
Feel free to open an issue or submit a pull request for any enhancements, fixes, or additional features you'd like to see in these scripts.

---

## License
This project is licensed under the MIT License.

--- 
