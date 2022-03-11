function Invoke-BEL_ClearCredentials(){
    $datapath = $PSScriptRoot + "\data\"
    $command = $datapath + 'bel_clearcredential.bat'
    write-Host($command)
    cmd.exe /c $command
}