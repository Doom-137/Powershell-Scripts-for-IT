${__Title} = 'Batch File Rename_Replace with Sequential Numbers'
${__Description} = @"
Asks for initial file path, loops through files 
in (sub)directories and renames files with seque-
ntial numbering regardless of file extension. Nu-
mbering resets with every individual directory.
"@

#################################################
$Counter = 0
$TargetDir = Read-Host 'Enter file path:'
$Padding = Read-Host "Enter desired file name length:"
Set-Location $TargetDir
$SubDirs = $(Get-ChildItem $TargetDir)

ForEach($SubDir in $SubDirs) {
	$Files = $(Get-ChildItem $SubDir)
	$Counter = 0

	ForEach($File in $Files) {
		$FileName = $File.FullName
		$FileExtension = [System.IO.Path]::GetExtension($File)
		If ($Padding -EQ 'n') {
			$NewNameWorkspace = $Counter.ToString().PadLeft((($Files.Count.ToString()).Length) -replace ' ','0')
		} Else {
			$NewNameWorkspace = $Counter.ToString().PadLeft([int]$Padding,'0')
		}
		$NewFileName = $NewNameWorkspace + $FileExtension
		Rename-Item $FileName $NewFileName
		$Counter += 1
	}
}
