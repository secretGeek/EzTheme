class Theme : ITheme {
    [string]$Name
    [string]$Path
    [Hashtable]$Settings = @{ }

    [System.Management.Automation.HiddenAttribute()]
    [void] LoadTheme() {
        $Theme = Import-Metadata $this.Path -ErrorAction Stop
        foreach ($key in $Theme.Keys) {
            $null = $this.Settings.Add($key, $Theme[$key])
        }
    }

    Theme ([string]$Path) {
        $this.Path = Convert-Path $Path
        $this.Name = [IO.Path]::GetFileName($this.Path) -replace "\.theme\.psd1$"
        $this.LoadTheme()
    }

    Theme ([ThemeId]$Path) {
        $this.Path = $Path.Path
        $this.Name = $Path.Name
        $this.LoadTheme()
    }

    [string[]] get_Modules() {
        return @($this.Settings.Keys)
    }

    [object] get_Item([string]$Module) {
        return $this.Settings[$Module]
    }

    [void] set_Item([string]$Module, [object]$Value) {
        $this.Settings[$Module] = $Value
    }

    [void] Remove([string]$ModuleName) {
        $this.Settings.Remove($ModuleName)
    }

    [string]ToString() {
        return $this.Name
    }
}