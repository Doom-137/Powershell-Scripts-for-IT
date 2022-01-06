${__Title} = 'Mass File Rename_Replace with Sequential Numbers'
${__Description} = @"
Asks for initial file path, loops through files 
in (sub)directories and renames files with seque-
ntial numbering regardless of file extension. Nu-
mbering resets with every individual directory.
"@

#################################################

$Counter = 0
$TargetDirectory = Read-Host 'Enter file path'
$Padding = Read-Host "Enter desired file name length (or type 'n' for auto-padding)"
Set-Location $TargetDirectory
$SubDirectories = $(Get-ChildItem $TargetDirectory)

ForEach($SubDirectory in $SubDirectories) {
	$Files = $(Get-ChildItem $SubDirectory)
    #Reset counter in preparation for next subdirectory
	$Counter = 0

	ForEach($File in $Files) {
		$FileName = $File.FullName
		#Get current file extension
		$FileExtension = [System.IO.Path]::GetExtension($File)
		If ($Padding -EQ 'n') {
			$NewNameWorkspace = $Counter.ToString().PadLeft((($Files.Count.ToString()).Length) -replace ' ','0')
		} Else {
			#Pad [Counter] for [NewFileName]
			$NewNameWorkspace = $Counter.ToString().PadLeft([int]$Padding,'0')
		}
		$NewFileName = $NewNameWorkspace + $FileExtension
		Rename-Item $FileName $NewFileName
		#Add 1 to [Counter]
		$Counter += 1
	}
}
