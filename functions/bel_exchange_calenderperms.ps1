
function Connect-BEL_ExchangeCalendarPerms{
  param(
    [string[]] $search
    )

    Get-Mailbox -filter {emailaddresses -like '*'+$search+'*'} | Foreach-Object {Get-MailboxFolderPermission -Identity ($_.identity + ':\Calendar')} | fl 
}
