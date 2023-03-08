# Connect to Exchange Online
Connect-ExchangeOnline

# Get a list of mailboxes containing "luba" in their display name
$mailboxes = Get-Mailbox -ResultSize Unlimited | Where-Object {$_.DisplayName -like "*conf*"}

# Initialize an array to store results
$results = @()

# Loop through each mailbox and add the calendar processing settings to the results array
foreach ($mailbox in $mailboxes) {
     $displayName = $mailbox.DisplayName

     try {
          # Retrieve the calendar processing settings for the mailbox
          $calendarProcessing = Get-CalendarProcessing -Identity $displayName

          # Create an object representing the calendar processing settings
          $output = [PSCustomObject]@{
               DisplayName = $displayName
               AutomateProcessing = $calendarProcessing.AutomateProcessing
               AddOrganizerToSubject = $caDeleteCommentslendarProcessing.AddOrganizerToSubject
               DeleteComments = $calendarProcessing.DeleteComments
               DeleteSubject = $calendarProcessing.DeleteSubject
               ProcessExternalMeetingMessages = $calendarProcessing.ProcessExternalMeetingMessages
               RemovePrivateProperty = $calendarProcessing.RemovePrivateProperty
               AddAdditionalResponse = $calendarProcessing.AddAdditionalResponse
               AdditionalResponse = $AdditionalResponse.ProcessExternalMeetingMessages

               AllowConflicts = $calendarProcessing.AllowConflicts
               BookingWindowInDays = $calendarProcessing.BookingWindowInDays
               MaximumDurationInMinutes = $calendarProcessing.MaximumDurationInMinutes
               AllowRecurringMeetings = $calendarProcessing.AllowRecurringMeetings
               EnforceSchedulingHorizon = $calendarProcessing.EnforceSchedulingHorizon
               ScheduleOnlyDuringWorkHours = $calendarProcessing.ScheduleOnlyDuringWorkHours
               ConflictPercentageAllowed = $calendarProcessing.ConflictPercentageAllowed
               MaximumConflictInstances = $calendarProcessing.MaximumConflictInstances
               ForwardRequestsToDelegates = $calendarProcessing.ForwardRequestsToDelegates
               AllRequestOutOfPolicy = $calendarProcessing.AllRequestOutOfPolicy
               BookInPolicy = $calendarProcessing.BookInPolicy
               RequestInPolicy = $calendarProcessing.RequestInPolicy


          }

          # Add the object to the results array
          $results += $output
     }
     catch {
          # Do this if a terminating exception happens
     }
}

# Display results
$results | Format-Table

# Export results to CSV
$results | Export-Csv -Path 'C:\Users\Brandon.luba\calendar_processing.csv' -NoTypeInformation
