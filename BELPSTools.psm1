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
echo $PSScriptRoot
print $PSScriptRoot

$functionpath = $PSScriptRoot + "\functions\"
$functionlist = Get-ChildItem -Path $functionpath -Name

foreach ($function in $functionlist){
    . ($functionpath + $function)
}