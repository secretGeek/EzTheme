class ThemeId : IPathInfo {
    [string]$Name
    [string]$Path

    ThemeId ([string]$Path) {
        $this.Path = Convert-Path $Path
        $this.Name = [IO.Path]::GetFileName($this.Path) -replace "\.theme\.psd1$"
    }

    [string]ToString() {
        return $this.Name
    }
}