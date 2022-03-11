function Invoke-BEL_ClearCredentials(){
    $datapath = $PSScriptRoot + "\data\"
    $command = $datapath + 'bel_clearcredential.cmd'
    write-Host($command)
    cmd.exe /c $command
}