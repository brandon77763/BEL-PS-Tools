
function Connect-BEL_ExchangeCalendarPerms{
  param(
    [string[]] $Search
    )

    Get-Mailbox -filter {emailaddresses -like '*$Search*'} | Foreach-Object {Get-MailboxFolderPermission -Identity ($_.identity + ':\Calendar')} | fl 
}
