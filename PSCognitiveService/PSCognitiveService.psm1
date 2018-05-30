using assembly System.Drawing
[cmdletbinding()]
param()

$BasePath = $PSScriptRoot

$dependencies = @(
    'Enum',
    'HashTable'
)

# define class sequence
$classList = @(
    'ValidateFile',
    'ValidateImage',
    'ValidateMarket',
    'ComputerVision',
    'Face',
    'TextAnalytics',
    'ContentModerator',
    'BingSearchV7',
    'BingEntitySearch',
    'BingImageSearch'
)

# importing enumerators and hashtables sequentially
foreach ($item in $dependencies) {
    Write-Verbose "Dot sourcing '$item.ps1'" 
    . "$BasePath\classes\$item.ps1"
}

# importing classes sequentially
foreach ($class in $classList) {
    Write-Verbose "Dot sourcing class '$class'"
    . "$BasePath\classes\$class.ps1"
}


# dot dourcing files
$FolderNames = @(
    'Private',
    'Public'
)

Get-ChildItem $($FolderNames.ForEach({"$BasePath\$_\"})) -Recurse -Filter *.ps1 | ForEach-Object {. $_.FullName}
