function Get-BEL_InstallModules(){
   Install-Module -Name ExchangeOnlineManagement
   Install-Module -Name InstallModuleFromGitHub
   Install-Module AzureAD -Force
}
