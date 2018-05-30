#
# Module manifest for module 'PSCognitiveService'
#
# Generated by: Prateek Singh
#
# Generated on: 4/18/2018
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSCognitiveService.psm1'

# Version number of this module.
ModuleVersion = '0.3.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'c2e17d6f-16c1-4afd-aad0-5c8ba0be10ee'

# Author of this module
Author = 'Prateek Singh'

# Company or vendor of this module
CompanyName = 'Prateek Singh'

# Copyright statement for this module
Copyright = '(c) 2018 Prateek Singh. All rights reserved.'

# Description of the functionality provided by this module
Description       = "PowerShell wrapper around Microsoft Azure Cognitive Services REST API's, to bring power of Machine Learning to your console and applications"

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
#RequiredModules = @('AzureRM')

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
#    ScriptsToProcess = @(
#        )
#
# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'ConvertTo-Thumbnail',
    'Get-Face',
    'Get-ImageAnalysis',
    'Get-ImageDescription',
    'Get-ImageTag',
    'Get-Imagetext',
    'Get-KeyPhrase',
    'Get-Sentiment',
    'New-CognitiveServiceInstance',
    'New-CognitiveServiceAccount'
    'New-LocalConfiguration',
    'Search-Entity',
    'Search-Web',
    'Search-Image',
    'Test-AdultRacyContent',
    'Trace-Language'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
#AliasesToExport = @('analyze','config','describe','thumbnail','ocr','tag','face','moderate')

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('azure','AzureRM','CognitiveService','AI')

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        ProjectUri   = 'https://github.com/PrateekKumarSingh/PSCognitiveService'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'Issues with New-CognitiveService cmdlet fixed'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
