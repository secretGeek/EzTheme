function Get-Theme {
    <#
        .SYNOPSIS
            List available themes, optionally filtering
        .DESCRIPTION
            List available themes, optionally filtering by partial name or functionality.
    #>
    [Alias("gth")]
    [CmdletBinding()]
    param(
        # The name of the theme(s) to show. Supports wildcards, and defaults to * everything.
        [string]$Name = "*",

        # If set, only returns themes that support theming all the specified modules
        [Alias("Module")]
        [AllowEmptyCollection()]
        [string[]]$SupportedModule,

        ## NOT IMPLEMENTED
        [string[]]$ExpandModule
    )
    Write-Verbose "Searching for theme: $Name"
    foreach ($Theme in FindTheme $Name) {
        if ($SupportedModule) {
            $ThemeData = [Theme]$Theme

            Write-Verbose "The $($ThemeData.Name) theme supports $($ThemeData.Modules -join ', ')"

            $SupportedModule.ForEach({
                $ExpectedModule = $_
                if ($ThemeData.Modules.ForEach({
                        $_ -eq $ExpectedModule -or $_ -like $ExpectedModule -or
                        $_ -eq "Theme.$ExpectedModule" -or $_ -eq "$ExpectedModule.Theme"
                    }) -notcontains $true) {
                    # skip outputting this theme because it doesn't support this module
                    Write-Verbose "The $Name theme doesn't support $ExpectedModule $($ThemeData.Modules -join ', ')"
                    continue # goes to the outer foreach in FindTheme
                }
            })
            $ThemeData
        } else {
            $Theme
        }
    }
}