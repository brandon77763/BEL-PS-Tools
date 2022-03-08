function Get-BEL_PasswordsThatNeverExpire(){
    get-aduser -filter * -properties Name, PasswordNeverExpires | where {
    $_.passwordNeverExpires -eq "true" } |  Select-Object DistinguishedName,Name,Enabled |
    Export-csv c:\data\pw_never_expires.csv -NoTypeInformation
}