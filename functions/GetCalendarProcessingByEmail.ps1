Get-Mailbox -filter {emailaddresses -like '*conf*'} | Foreach-Object { Get-CalendarProcessing -Identity ($_.identity)} | export-csv "C:\Users\Brandon.luba\CalendarProcessing.csv"
