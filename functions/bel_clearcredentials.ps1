function Invoke-BEL_ClearCredentials(){
    $datapath = $PSScriptRoot + "\data\"
    write-Host($datapath)
     cmd.exe /c $datapath + "bel_clearcredential.bat"
}