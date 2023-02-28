# Get all users from Active Directory
$users = Get-ADUser -Filter * -Properties SIPAddress, UserPrincipalName

# Loop through each user and check for matching SIP and UPN
foreach ($user in $users) {
    if ($user.SIPAddress -eq $user.UserPrincipalName) {
        Write-Host "User $($user.Name) has matching SIP and UPN: $($user.SIPAddress)"
    }
}
