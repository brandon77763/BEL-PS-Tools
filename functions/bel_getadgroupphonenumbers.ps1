function Get-BEL_GetADGroupPhoneNumbers(){
    Param(
    [string[]] $search
    )
    Get-ADGroupMember -Identity $search -Recursive | Foreach-Object {get-aduser -filter * -searchbase $_.distinguishedName -properties Telephonenumber|select displayname, givenname, name, sn, telephonenumber} | export-csv 'C:\' + $search + 'phones.csv'
}