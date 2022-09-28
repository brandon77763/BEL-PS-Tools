function Get-BEL_InstallModules(){
   Install-Module -Name PowerShellGet -Force -AllowClobber
   Install-Module -Name ExchangeOnlineManagement -Force
   Install-Module -Name InstallModuleFromGitHub -Force
   Install-Module AzureAD -Force
   Install-Module -Name MicrosoftTeams -Force -AllowClobber
}
