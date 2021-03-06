# Use this file to override the default parameter values used by the `Build-Module`
# command when building the module (see `Get-Help Build-Module -Full` for details).
@{
    ModuleManifest           = "Theme.WindowsTerminal.psd1"
    VersionedOutputDirectory = $false
    CopyDirectories          = @('WindowsTerminal.format.ps1xml')
    Postfix                  = "postfix.ps1"
}
