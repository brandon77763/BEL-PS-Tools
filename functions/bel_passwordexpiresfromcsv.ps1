function Get-BEL_PasswordExpiresFromList(){
    $csv = Import-Csv "Path to csv file"
    $UserPrincipalName= $csv.UserPrincipalName
    foreach ($obj in $UserPrincipalName){
        Get-AzureADUser -ObjectID $obj | Select-Object @{N="PasswordNeverExpires";E={$_.PasswordPolicies -contains "DisablePasswordExpiration"}} | fl
    }
}