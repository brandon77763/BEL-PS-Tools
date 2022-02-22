Install-Module -Name InstallModuleFromGitHub
Remove-Module BELPSTools
Install-ModuleFromGitHub -GitHubRepo brandon77763/BELPSTools
Rename-Item -Path ".\BELPSTools-main" -NewName ".\BELPSTools"