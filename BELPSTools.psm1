<#
 .Synopsis
  Displays a visual representation of a calendar.

 .Description
  Displays a visual representation of a calendar. This function supports multiple months
  and lets you highlight specific date ranges or days.

 .Example
   # Show a default display of this month.
   Show-Calendar
#>
#Update 

function Get-BEL-Update {
    powershell  .\build\bel_update.ps1
}

function Show-BEL_RTFM {
    powershell  .\functions\bel_rtfm.ps1
}