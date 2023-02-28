# Connect to Azure AD
Connect-AzureAD

# Get all users from Azure AD
$users = Get-AzureADUser -All $true | Select-Object DisplayName, UserPrincipalName, Mail, SignInNames

# Loop through each user and check for matching SIP and UPN
foreach ($user in $users) {
    # Get the user's SIP address from the SignInNames array
    $sipAddress = $user.SignInNames | Where-Object { $_.Type -eq 'sip' } | Select-Object -ExpandProperty Value
    
    if ($sipAddress -eq $user.UserPrincipalName) {
        Write-Host "User $($user.DisplayName) has matching SIP and UPN: $($sipAddress)"
    }
}
