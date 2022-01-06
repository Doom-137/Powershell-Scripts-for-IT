${__Title} = 'Batch File Rename_Replace with Random Characters'
${__Description} = @"
Asks for initial file path, loops through files 
in (sub)directories and renames files with rando-
m characters regardless of file extension.
"@

#################################################
$TargetDir = Read-Host 'Enter file path:'
$RandomStringLength = Read-Host 'Enter desired file name length:'
Set-Location $TargetDir
$SubDirs = $(Get-ChildItem $TargetDir)

ForEach($SubDir in $SubDirs) {
	$Files = $(Get-ChildItem $SubDir)

	ForEach($File in $Files) {
		$FileName = $File.FullName
		$FileExtension = [System.IO.Path]::GetExtension($File)
		$NewNameWorkspace = -Join ((33..126) * [int]$RandomStringLength | Get-Random -Count 32 | % {[char]$_})
		$NewFileName = $NewNameWorkspace + $FileExtension
		Rename-Item $FileName $NewFileName
	}
}
