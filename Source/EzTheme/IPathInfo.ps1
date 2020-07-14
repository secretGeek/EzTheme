add-type -TypeDefinition @'
public interface IPathInfo {
    public string Name { get; set; }
    public string Path { get; set; }
}
public interface ITheme : IPathInfo {
    string[] Modules { get; }
    object this[System.String module] { get; set; }
}
'@
