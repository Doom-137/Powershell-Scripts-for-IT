${__Title} = 'Mass File Rename_Replace with Random Characters'
${__Description} = @"
Asks for initial file path, loops through files 
in (sub)directories and renames files with rando-
m characters regardless of file extension.
"@

#################################################
$TargetDirectory = Read-Host 'Enter file path'
$RandomStringLength = Read-Host 'Enter desired file name length'
Set-Location $TargetDirectory
$SubDirectories = $(Get-ChildItem $TargetDirectory)

ForEach($SubDirectory in $SubDirectories) {
	$Files = $(Get-ChildItem $SubDirectory)

	ForEach($File in $Files) {
		$FileName = $File.FullName
		#Get current file extension
		$FileExtension = [System.IO.Path]::GetExtension($File)
		#Pad [Counter] for [NewFileName]
		$NewNameWorkspace = -Join ((33..126) * [int]$RandomStringLength | Get-Random -Count 32 | % {[char]$_})
		$NewFileName = $NewNameWorkspace + $FileExtension
		Rename-Item $FileName $NewFileName
	}
}
