Install-Module -Name InstallModuleFromGitHub
Start-Sleep -s 2
Remove-Module BELPSTools
Start-Sleep -s 2
Install-ModuleFromGitHub -GitHubRepo brandon77763/BELPSTools
Start-Sleep -s 2
Remove-Item '.\BELPSTools' -Recurse
Start-Sleep -s 5
Rename-Item -Path ".\BELPSTools-main" -NewName ".\BELPSTools"
Start-Sleep -s 2