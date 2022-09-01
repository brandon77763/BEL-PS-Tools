function Get-BEL_AD_GetPhoneNumbersInGroup(){
    Get-ADGroupMember -Identity "IT Staff" -Recursive | Foreach-Object {get-aduser -filter * -searchbase $_.distinguishedName -properties Telephonenumber|select displayname, givenname, name, sn, telephonenumber} | export-csv C:\crbgroupITphones.csv
}