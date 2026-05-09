Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
$CSV = 'C:\Users\mails\CSV.csv' ##Replace with the path to where the CSV should be output
   
   
Add-Content -Path $CSV  -Value 'Directory,File name,LastWriteTime,Owner'
 
$recentlychanged = gci C:\NT\Zion\SampleInvoices -Recurse -Filter *.pdf | Where-Object {$_.Lastwritetime -lt ((Get-Date).adddays(-45)) }
$recentlychanged | Select-Object directory,fullname,lastwritetime,@{Name="Owner";Expression={ (Get-Acl $_.FullName).Owner }} | ConvertTo-Csv -NoTypeInformation | Sort-Object lastwritetime | Out-File -Append $CSV
