function Get-BEL_Update(){
write-Host Updating GitHub Module..... 
Install-Module -Name InstallModuleFromGitHub -RequiredVersion 0.3
Start-Sleep -s 5
write-Host Removing Old BELPSTools Module..... 
Remove-Module BELPSTools
Start-Sleep -s 5
write-Host Downloading New BELPSTools Module..... 
Install-ModuleFromGitHub -GitHubRepo brandon77763/BELPSTools
Start-Sleep -s 15
write-Host Removing Old BELPSTools Files Module..... 
Remove-Item '.\BELPSTools' -Recurse
Start-Sleep -s 5
write-Host Configuring New BELPSTools Files Module..... 
Rename-Item -Path ".\BELPSTools-main" -NewName ".\BELPSTools"
Start-Sleep -s 5
write-Host Tasks Completed..... 
Start-Sleep -s 3
Exit
}

