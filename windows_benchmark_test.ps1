# Install stress utility if needed
# choco install stress -y 
# Run as admin 
# https://customers.jam-software.de/downloadTrial.php?language=EN&article_no=402

# Function to display a loading bar
function Show-LoadingBar {
    param (
        [int]$duration
    )
    $barLength = 50
    $increment = [math]::floor($duration / $barLength)

    Write-Host -NoNewline "["
    for ($i = 0; $i -le $barLength; $i++) {
        Start-Sleep -Milliseconds $increment
        Write-Host -NoNewline "#"
        Write-Progress -Activity "Benchmark Progress" -PercentComplete (($i / $barLength) * 100)
    }
    Write-Host "] 100% complete"
}

# Function to run a command with a loading bar
function Run-WithLoadingBar {
    param (
        [ScriptBlock]$command,
        [int]$duration
    )
    Start-Job -ScriptBlock { & $command }
    Show-LoadingBar -duration $duration
    Wait-Job -State Completed
}

# Initialize report
$reportFile = "C:\memory_report.txt"
Add-Content $reportFile "`n========================"
Add-Content $reportFile "Hostname info"
Add-Content $reportFile "`n================="
Add-Content $reportFile (hostname)
Add-Content $reportFile "`n========================"

# Basic Memory Benchmark Test
Add-Content $reportFile "Basic Memory Benchmark Test"
Add-Content $reportFile "========================"
Show-LoadingBar -duration 10
$winsatMemoryResult = winsat mem
Add-Content $reportFile $winsatMemoryResult

# Intermediate Memory Benchmark Test
Add-Content $reportFile "`nIntermediate Memory Benchmark Test"
Add-Content $reportFile "========================"
Show-LoadingBar -duration 10
$winsatMemoryResult2 = winsat mem
Add-Content $reportFile $winsatMemoryResult2

# Advanced Memory Benchmark Test
Add-Content $reportFile "`nAdvanced Memory Benchmark Test"
Add-Content $reportFile "========================"
Show-LoadingBar -duration 10
$winsatMemoryResult3 = winsat mem
Add-Content $reportFile $winsatMemoryResult3

# Uncomment this section to run on Hyper-V VMs
# VM Memory Test
# Add-Content $reportFile "`nVM Memory Test"
# Add-Content $reportFile "==============="
# Get-VM | ForEach-Object {
#     $vmId = $_.VMId
#     Add-Content $reportFile "Running test on VM ID $vmId..."
#     # Add your VM memory test here
#     Add-Content $reportFile "==================="
# }

# Basic Stress Test
Add-Content $reportFile "`nBasic Stress Test on Host"
Add-Content $reportFile "========================"
Show-LoadingBar -duration 60
& "C:\Program Files\stress\stress.exe" --cpu 2 --timeout 60 >> $reportFile

# Intermediate Stress Test
Add-Content $reportFile "`nIntermediate Stress Test on Host"
Add-Content $reportFile "============================="
Show-LoadingBar -duration 60
& "C:\Program Files\stress\stress.exe" --cpu 4 --timeout 60 >> $reportFile

# Advanced Stress Test
Add-Content $reportFile "`nAdvanced Stress Test on Host"
Add-Content $reportFile "============================="
Show-LoadingBar -duration 60
& "C:\Program Files\stress\stress.exe" --cpu 8 --timeout 60 >> $reportFile

# Huge Pages info
Add-Content $reportFile "`nHuge Pages Info"
Add-Content $reportFile "============================="
Get-WmiObject -Query "SELECT * FROM Win32_OperatingSystem" | ForEach-Object { $_.TotalVisibleMemorySize } >> $reportFile

Write-Host "Report saved in $reportFile"
