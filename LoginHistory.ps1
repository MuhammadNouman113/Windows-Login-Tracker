# PowerShell Script: Fetch last 50 unique user logins in Windows
# Excludes system/service accounts and removes duplicate logins

# Define the time range (fetch only last 7 days of logs)
$startTime = (Get-Date).AddDays(-7)

# Use -MaxEvents to limit retrieval & -FilterXPath for efficiency
$logins = Get-WinEvent -LogName Security -MaxEvents 1000 | Where-Object {
    $_.Id -eq 4624 -and
    $_.TimeCreated -ge $startTime -and
    ($_.Properties[8].Value -eq 2 -or $_.Properties[8].Value -eq 10 -or $_.Properties[8].Value -eq 11) -and
    $_.Properties[5].Value -notmatch "^(DWM-|UMFD-)"
} | Select-Object TimeCreated,
    @{Name="User"; Expression={$_.Properties[5].Value}},
    @{Name="SessionID"; Expression={$_.Properties[7].Value}} |
    Sort-Object TimeCreated -Descending |
    Group-Object SessionID | Select-Object -First 50 |
    Format-Table 
