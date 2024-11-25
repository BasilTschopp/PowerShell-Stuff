$csvFile        = "input.csv"
$csvColumnPath  = "Path"   
$csvColumnRename = "Rename"
$csvArray       = Import-Csv -Path $csvFile
$TargetFolder   = "target folder"

if (!(Test-Path -Path $TargetFolder)) {
    New-Item -ItemType Directory -Path $TargetFolder | Out-Null
    Write-Host "Folder $TargetFolder created"
}

foreach ($Row in $csvArray) {

    $SourceFilePath = Join-Path -Path $PSScriptRoot -ChildPath $Row.$csvColumnPath
    $FileExtension = [System.IO.Path]::GetExtension($SourceFilePath)
    $NewFileName = ($Row.$csvColumnRename -replace '[<>:"/\\|?*]', '_') + $FileExtension
    $DestinationFilePath = Join-Path -Path $TargetFolder -ChildPath $NewFileName

    Copy-Item -Path $SourceFilePath -Destination $DestinationFilePath -Force
    Write-Host "$NewFileName"

}

Read-Host "Press Enter to exit"