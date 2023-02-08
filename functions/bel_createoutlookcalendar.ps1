
$domain = ""
$AV
$roomname
$displayname
$pwd1
$siteidentifer = $null
$prefix = "Conf"
$email
$alias
#Room 
$Capacity
$CountryOrRegion
$Building
$Floor
$FloorLabel
$Label





function set-sleep($delay){
    Start-Sleep -Seconds $delay
}

Connect-AzureAD


function get-ExchangeOnlineConnection{
    #Connect & Login to ExchangeOnline (MFA)
    $getsessions = Get-PSSession | Select-Object -Property State, Name
    $isconnected = (@($getsessions) -like '@{State=Opened; Name=ExchangeOnlineInternalSession*').Count -gt 0
    If ($isconnected -ne "True") {
        Connect-ExchangeOnline
    }    
}
get-ExchangeOnlineConnection

function build-build{
    try {
        Write-Host "Creating Account..." -ForegroundColor Blue
        New-Mailbox -MicrosoftOnlineServicesID $email -Alias $alias -Name "$roomname" -DisplayName "$displayname" -Room -EnableRoomMailboxAccount $true -RoomMailboxPassword (ConvertTo-SecureString -String $pwd1 -AsPlainText -Force)
        set-sleep(4)
        Write-Host "Setting Mailbox Permissions..." -ForegroundColor Blue
        Set-MailboxFolderPermission -Identity $alias':\Calendar' -User Default -AccessRights LimitedDetails
        set-sleep(4)
        Write-Host "Setting Mailbox Location Info..." -ForegroundColor Blue
        Set-Place -Identity "$alias" -Building "$Building" -Capacity "$Capacity" -CountryOrRegion $CountryOrRegion -Floor "$Floor" -FloorLabel "$FloorLabel" -Label "$Label"
        set-sleep(4)
        Write-Host "Applying Calendar Proccessing Variables..." -ForegroundColor Blue
        Set-CalendarProcessing -Identity "$alias" -AutomateProcessing AutoAccept -AddOrganizerToSubject $false -DeleteComments $false -DeleteSubject $false -ProcessExternalMeetingMessages $true -RemovePrivateProperty $false -AddAdditionalResponse $true -AdditionalResponse "This is a Microsoft Teams Meeting room!"
        set-sleep(4)
        Write-Host "###########Gathering Account Info###########" -ForegroundColor Blue
        Get-CalendarProcessing -Identity "$alias" | fl
        set-sleep(4)
        Get-MailboxFolderPermission -Identity $alias':\Calendar' | fl
        set-sleep(4) 
        if(![string]::IsNullOrEmpty($email)){
            set-sleep(10)
            Write-Host "DisablePasswordExpiration..." -ForegroundColor Blue
            Set-AzureADUser -ObjectID '$email' -PasswordPolicies DisablePasswordExpiration
        }
    }
    catch {
        Write-Host "An error occurred:"
        Write-Host $_
    }
    $A1 = Read-Host "Do you want to create another room? Type(yes or no) "
    while("yes","no" -notcontains $AV)
    {
        $A1 = Read-Host "Do you want to create another room? Type(yes or no) "
    }
    if($A1 -contains "no"){
        exit
    }else {
        get-inputbox
    }
   
}


function get-inputbox{
    Write-Host "Welcome to Calender Creation Automation!!!" -ForegroundColor Green
    $roomname = Read-Host -Prompt "Enter the confrence room name "
    $Capacity = Read-Host -Prompt "Please enter the rooms capacity "
    $Building = Read-Host -Prompt "Please enter building and or site "
    $Floor = Read-Host -Prompt "Please enter the floor the room is on "
    $FloorLabel = Read-Host -Prompt "Please enter the floor label "
    $Label = Read-Host -Prompt "Please enter the floor label "
    $CountryOrRegion = Read-Host -Prompt "Please enter the Country or Region EX: US, SE, DE, CH, CA "


    $pwd1 = Read-Host -Prompt "Enter the new confrence room password" -AsSecureString
    
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
    Write-Host "Capacity is set to "  -ForegroundColor Green
    Write-Host $Capacity -ForegroundColor Blue
    Write-Host "Building is set to "  -ForegroundColor Green
    Write-Host $Building -ForegroundColor Blue
    Write-Host "Floor is set to "  -ForegroundColor Green
    Write-Host $Floor -ForegroundColor Blue
    Write-Host "FloorLabel is set to "  -ForegroundColor Green
    Write-Host $FloorLabel -ForegroundColor Blue
    Write-Host "Label is set to "  -ForegroundColor Green
    Write-Host $Label -ForegroundColor Blue

    $ConfirmSettings = Read-Host "Do you confirm the creation of this room account? Type(yes or no) "
    while("yes","no" -notcontains $ConfirmSettings)
    {
        $ConfirmSettings = Read-Host "Do you confirm the creation of this room account? Type(yes or no) "
    }
    if($ConfirmSettings -contains "yes"){
        build-build
    }else {
        Write-Host "You have chosen to cancel the creation of this account. Now ending this script." -ForegroundColor Red
        $A1 = Read-Host "Do you want to create another room? Type(yes or no) "
        while("yes","no" -notcontains $AV)
        {
            $A1 = Read-Host "Do you want to create another room? Type(yes or no) "
        }
        if($A1 -contains "no"){
            exit
        }else {
            get-inputbox
        }
    }

    pause
}

get-inputbox


(Get-PSReadlineOption).HistorySavePath

pause
