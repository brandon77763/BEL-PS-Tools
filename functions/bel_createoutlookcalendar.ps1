
$domain = ""
$AV
$roomname
$displayname
$pwd1
$siteidentifer = $null
$prefix = "Conf"
$email
$alias




# EMAIL: PHL.Conf.Roomname@domain.com
# NAME: PHL Conf RoomName {VC}





function check-ExchangeOnlineConnection{
    #Connect & Login to ExchangeOnline (MFA)
    $getsessions = Get-PSSession | Select-Object -Property State, Name
    $isconnected = (@($getsessions) -like '@{State=Opened; Name=ExchangeOnlineInternalSession*').Count -gt 0
    If ($isconnected -ne "True") {
        Connect-ExchangeOnline
    }    
}
#check-ExchangeOnlineConnection


function create-room-account{
    New-Mailbox -MicrosoftOnlineServicesID "$email" -Alias $roomname -Name "$roomname" -DisplayName "$displayname" -Room -EnableRoomMailboxAccount $true -RoomMailboxPassword (ConvertTo-SecureString -String $pwd1 -AsPlainText -Force)
}

function check-calendar-permissions{
    Get-MailboxFolderPermission -Identity '*'$roomname':\Calendar' | fl 
}

function set-calendar-permissions{
    Set-MailboxFolderPermission -Identity '*'$roomname':\Calendar' -User Default -AccessRights LimitedDetails
}

function set-calendar-processing{
    Set-CalendarProcessing "resource name" –AllRequestOutofPolicy $false
}


function display-inputbox{
    Write-Host "Welcome to Calender Creation Automation!!!" -ForegroundColor Green
    $roomname = Read-Host -Prompt "Enter the confrence room name "
    $pwd1 = Read-Host -Prompt ‘Enter the new confrence room password’ -AsSecureString
    
    $AV = Read-Host "Does this room have video functionality? Type(yes or no) "
    while("yes","no" -notcontains $AV)
    {
        $AV = Read-Host "Does this room have video functionality? Type(yes or no) "
    }

    $siteidentifer = Read-Host "Please enter a site identifer. Examples: PHL , LAX , STL , LNX "
    while(!$siteidentifer)
    {
        $siteidentifer = Read-Host "Please enter a site identifer. Examples: PHL , LAX , STL , LNX "
    }

    if($AV -contains "no"){
        $displayname = $siteidentifer + " " + $prefix + " " + $roomname
    }else {
        $displayname = $siteidentifer + " " + $prefix + " " + $roomname + ' {AV}'
    }

    $email = $siteidentifer + "." + $prefix + "." + $roomname + "@$domain"
    $alias = $siteidentifer + "." + $prefix + "." + $roomname

    
    #$city= Read-Host -Prompt "Enter your city"
    #Write-Host "The entered room name is" $roomname -ForegroundColor Green


    Write-Host ""
    Write-Host "The entered room name is "  -ForegroundColor Green 
    Write-Host $roomname -ForegroundColor Blue
    Write-Host "Is this an AV room? This is set as " -ForegroundColor Green
    Write-Host $AV -ForegroundColor Blue
    Write-Host "Display name is set to " -ForegroundColor Green
    Write-Host $displayname -ForegroundColor Blue
    Write-Host "Alias name is set to " -ForegroundColor Green
    Write-Host $alias -ForegroundColor Blue
    Write-Host "Email is set to "  -ForegroundColor Green
    Write-Host $email -ForegroundColor Blue

    $ConfirmSettings = Read-Host "Do you confirm the creation of this room account? Type(yes or no) "
    while("yes","no" -notcontains $ConfirmSettings)
    {
        $ConfirmSettings = Read-Host "Do you confirm the creation of this room account? Type(yes or no) "
    }
    if($ConfirmSettings -contains "yes"){
        #$displayname = $roomname
    }else {
        Write-Host "You have chosen to cancel the creation of this account. Now ending this script."
        Pause
        exit
    }

    pause
}

display-inputbox




(Get-PSReadlineOption).HistorySavePath

pause
