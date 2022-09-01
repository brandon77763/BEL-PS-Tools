function Get-BEL_InstallModules(){
   Install-Module -Name PowerShellGet -Force -AllowClobber
   Install-Module -Name ExchangeOnlineManagement
   Install-Module -Name InstallModuleFromGitHub
   Install-Module AzureAD -Force
   Install-Module -Name MicrosoftTeams -Force -AllowClobber
}
