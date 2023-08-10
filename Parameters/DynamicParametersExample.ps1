function Invoke-DBSearch {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet('SQL', 'MongoDB')]
        [string]
        $DatabaseType
    )

    dynamicparam {
        $attributeCollection = [System.Collections.ObjectModel.Collection[System.Attribute]]::new()
        $paramAttributes = [System.Management.Automation.ParameterAttribute]::new()
        $paramAttributes.Mandatory = $true
        $attributeCollection.Add($paramAttributes)

        switch ($DatabaseType){
            'SQL'{
                $param = [System.Management.Automation.RuntimeDefinedParameter]::new(
                    "SQLQuery",
                    [string],
                    $attributeCollection
                )
                $paramDictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()
                $paramDictionary.Add("SQLQuery", $param)
            }

            'MongoDB'{
                $param = [System.Management.Automation.RuntimeDefinedParameter]::new(
                    "JSONBlob",
                    [string],
                    $attributeCollection
                )
                $paramDictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()
                $paramDictionary.Add("JSONBlob", $param)
            }
        }

        return $paramDictionary
    }

    process {
        try {
            switch ($DatabaseType){
                'SQL'{
                    Write-Output "Adding SQL Query: [$($PSBoundParameters.SQLQuery)]"
                }

                'MongoDB'{
                    Write-Output "Adding MongoDB JSON blob: [$($PSBoundParameters.JSONBlob)]"
                }
            }
        } catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}
