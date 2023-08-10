class ValidateCSVFileExistsAttribute : System.Management.Automation.ValidateArgumentsAttribute {
    [void]Validate([object]$csvFile, [System.Management.Automation.EngineIntrinsics]$engineIntrinsics) {
        if([string]::IsNullOrWhiteSpace($csvFile)) {
            throw [System.ArgumentNullException]::new()
        } elseif(-not (Test-Path -Path $csvFile)) {
            throw [System.IO.FileNotFoundException ]::new()
        }
    }
}

[ValidateCSVFileExists()]
[string]$csv = "C:\Temp\MyFile.csv"
