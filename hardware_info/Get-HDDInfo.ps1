$HDDList = Get-WMIObject -Class win32_PhysicalMedia -ComputerName $env:ComputerName
Write-Host "Computer Name: " $env:ComputerName.Trim() "`n"
$Subby = ""
foreach($HDD in $HDDList)
{
	$HDD2 = $HDD  -replace ".*=" -replace ".*\\\\.\\\\" -replace "`""
	Write-Host "`tDrive Identifier: " $HDD2
	
	if ($HDD.SerialNumber)
	{
		Write-Host "`tSerial Number: " $HDD.SerialNumber.Trim() "`n"
	}
	else
	{
		Write-Host "`tSerial Number: None Available`n"
	}
	
#	$HDDLetters2 = $HDDLetters -replace ".*="
#	Write-Host "`tDrive Letter: " $HDDLetters2
}
[void][System.Console]::ReadKey($true)
$HDDLetters = Get-WMIObject -Class Win32_LogicalDisk -ComputerName $env:ComputerName

[void][System.Console]::ReadKey($true)
