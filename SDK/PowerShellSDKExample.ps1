[PowerShell]::Create().
    AddCommand("Get-childItem").
        AddParameter("Path", "C:\Temp").
    Invoke()
