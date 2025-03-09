# PowerShell Script: Fetch last 50 unique user logins in Windows
# Excludes system/service accounts and removes duplicate logins

$logins = Get-WinEvent -LogName Security | Where-Object {
    $_.Id -eq 4624 -and 
    ($_.Properties[8].Value -eq 2 -or $_.Properties[8].Value -eq 10 -or $_.Properties[8].Value -eq 11) -and 
    $_.Properties[5].Value -notmatch "^(DWM-|UMFD-)"
} | Select-Object TimeCreated, 
    @{Name="User"; Expression={$_.Properties[5].Value}}, 
    @{Name="SessionID"; Expression={$_.Properties[7].Value}} | 
    Sort-Object TimeCreated -Descending | 
    Get-Unique -AsString -On SessionID | 
    Select-Object -First 50 | 
    Format-Table -AutoSize
