Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force

$filename = $env:COMPUTERNAME + ' ' + $(Get-Date -f yyyy-MM-dd-hh-mm-ss)
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$Commands2Run = @("systeminfo","getmac","ipconfig /flushdns","ipconfig /all","arp -av","route print","netsh wlan show drivers","netsh wlan show interfaces","netsh wlan show networks mode=Bssid","netsh wlan show all","ping google.com","tracert 8.8.8.8","pathping google.com"," ipconfig /displaydns","pathping google.com") 

$jobs = @()
foreach ($Command2 in $Commands2Run) { 
    $job = Start-Job -ScriptBlock {
        param($command)
        cmd.exe /c $command | Out-String
    } -ArgumentList $Command2

    $job | Add-Member -NotePropertyName CommandName -NotePropertyValue $Command2
    $jobs += $job
}

while (($jobs | Where-Object -Property HasMoreData -eq $true).Count -gt 0) {
    $index = 0
    foreach ($job in $jobs) {
        $index++
        if ($job.HasMoreData) {
            $result = Receive-Job -Job $job
            $result >> "$DesktopPath/$filename.txt"
        }
        
        $currentCommand = $job.CommandName
        if ($job.State -eq 'Running') {
            Write-Progress -Id $index -Activity "Running Command: $currentCommand" -Status "Still running..." -PercentComplete -1
        } else {
            Write-Progress -Id $index -Activity "Running Command: $currentCommand" -Status "Completed!" -Completed
        }
    }
    Start-Sleep -Seconds 1
}

# Cleanup jobs
$jobs | Remove-Job
