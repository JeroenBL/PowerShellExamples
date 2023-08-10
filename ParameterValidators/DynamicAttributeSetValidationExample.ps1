function Get-Something {
    [CmdletBinding()]
    param()
    dynamicparam {
        $attributeCollection = [System.Collections.ObjectModel.Collection[System.Attribute]]::new()
        $attributeCollection.Add((New-Object System.Management.Automation.ValidateSetAttribute(([MyEnumType]::GetValues([MyEnumType])))))

        $paramAttributes = [System.Management.Automation.ParameterAttribute]::new()
        $paramAttributes.Mandatory = $true
        $attributeCollection.Add($paramAttributes)

        $param = [System.Management.Automation.RuntimeDefinedParameter]::new(
            "MyParameter",
            [string],
            $attributeCollection
        )
        $paramDictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()
        $paramDictionary.Add("MyParameter", $param)
        return $paramDictionary
    }
}

enum MyEnumType {
    Value1
    Value2
    Value3
    Value4
}
